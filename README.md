# Coderunner Customization
This repository contains files with which the Coderunner Moodle Plugin can be extended.
Currently, a mode for the Ace-Editor to support syntax highlighting for Relational Algebra questions is provided.

## Extending the Coderunner Moodle Plugin with custom modes

1. Paste the desired mode-*.js file into the plugin directory, under /ace.
2. Adjust the following files:
- /ace/ext-prompt.js
- /ace/ext-settings_menu.js
- /ace/ext-options.js
- /ace/ext-modelist.js

by adding the following entry to the *supportedModes* dictionary (example for [Relational Algebra](./mode-relalg.js):

´´´
RelAlg: ["relalg"]
´´´

3. Purge the caches in Moodle under Site Administration -> Development -> Purge Caches
4. When creating a Coderunner question, under *Advanced Customisation*, set the *Ace Language* accodordingly, e.g. **relalg**.


## Creating a custom mode

1. Start with an already existing mode and adjust it accordingly.


## Setting up the Moodle Coderunner Plugin to work with the eTutor++ (dke-dispatcher)

1. After installing the plugin, you might have to change the Moodle security settings to enable communication with the Jobe server.
2. Install the requests module on your Jobe server using pip.
3. Add a Coderunner question to the question bank.
- Use python3 as question type.
- Under Customisation, add the [template](./template.py).
- Choose a template grader with the result columns *[["Kriterium", "criterion"],["Ergebnis", "result", "%h"]]*.
- Under advanced customisation, set the question as prototype and set the name, e.g. etutor.
4. Create a question based upon the new prototype.
- As question type, choose the newly created prototype.
- Under *Coderunner question type* choose *Customise*.
- Enable *Precheck* (Selected) and tick *Hide check*.
- Choose an *All-or-nothing-grading* with a penalty regime of *0*.
- As template params, add the following JSON:
{
"EXERCISE_ID": 13598,
"DIAGNOSE_LEVEL": 0,
"TASK_TYPE": "sql"
}
*Note*: Replace the id with the *disptacherId* of an exisitng question in the eTutor++ platform and change the task_type (has to match dispatcher task types).
- Under advanced customisation, set the *Ace Language* accordingly.
- Under *Answer*, add the correct solution (choose *Validate on save* if you want to).
- Under *Test Cases*, add two test cases. Each test-case is defined by the Standard Input that sets the mode for the evaluation by the dke-dispatcher. Create one test-case for *Preckeck only* with the input 'run'. Create another test-case for *Check Only* with the input 'submit'.
5. Use the *Preview* function at the bottom to verify if everything works.

**Tipp:** For each question type (e.g. SQL) you can create one question that can be used as a template. For further questions of the same type, you can duplicate this question and only replace the disptacher-id of the question, the correct solution and question text. 

