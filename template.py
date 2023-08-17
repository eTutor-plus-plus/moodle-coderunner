import json
import requests


__student_answer__ = """{{ STUDENT_ANSWER | e('py') }}"""

## 1. Construct submission - dto
action = {{ TEST.stdin }}
submission = __student_answer__
diagnose_level = {{ DIAGNOSE_LEVEL }}
exercise_id = {{ EXERCISE_ID }}
task_type = """{{ TASK_TYPE }}"""

## 2. Send submission
submission_url = 'http://dke-dispatcher:8080/submission'
submission_payload = {
    'taskType': task_type,
    'exerciseId': exercise_id,
    'passedAttributes': {
        'action': action,
        'submission': submission,
        'diagnoseLevel': diagnose_level
    },
    'passedParameters': {}
}
headers = {'Content-Type': 'application/json'} # todo: add locale (fetch from moodle somehow)

response = requests.post(submission_url, json=submission_payload, headers=headers)
submission_id = response.json()['submissionId']

## 3. Fetch grading
grading_url = f'http://dke-dispatcher:8080/grading/{submission_id}'

# Send request to fetch grading
grading_response = requests.get(grading_url) # todo: add delay??

# Parse the JSON response
grading_data = grading_response.json()

# Read the desired fields from the response
result = grading_data['result']
submission_suits_solution = grading_data['submissionSuitsSolution']


mark = 0
if submission_suits_solution:
    mark = 1

criterion = 'Correct Result'
if action == 'run':
    criterion = 'No Syntax Errors'

## 4. Construct feedback
# todo: do not indicate correctness for diagnose submission
feedback = {
    'fraction': mark / 1,
    'result': result,
    'criterion': criterion
}

print(json.dumps(feedback))