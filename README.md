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

