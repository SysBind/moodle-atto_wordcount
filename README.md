# ATTO Word Count [![Build Status](https://github.com/SysBind/moodle-atto_wordcount/actions/workflows/ci.yml/badge.svg?branch=main)]((https://github.com/SysBind/moodle-atto_wordcount/actions))
Add "real time" words count to Moodle Atto editor, By enable this Atto plugin the user will see a new bottom atto toolbar with the count of the words in the current Atto editor.
The count is change will the user type or change the Atto editor content.

You can see examples in the screenshots bellow.

## Requirements
- Moodle 3.11 or later.

## Installation
1. Add the plugin to /lib/editor/atto/plugins
1. Run the Moodle upgrade.
1. In the browser go to /admin/category.php?category=editoratto in Your moodle domain
1. In the editor_atto | toolbar field add the wordcount (You can add it right after the html button for example: other = html,wordcount)
1. Save the settings

## Records
Thanks to the Hebrew University Of Jerusalem that sponsor this plugin development.
![Hebrew University Of Jerusalem](https://moodle.org/pluginfile.php/50/local_plugins/plugin_description/2743/logo-ltr.png)

## Author
Avi Levy (avi@sysbind.co.il)
![SysBind](https://moodle.org/pluginfile.php/50/local_plugins/plugin_description/2743/Sysbind-Moodle-Partner-Landscape.png)
André Menrath (andre.menrath@uni-graz.at)

## License ##
2021 SysBind
2022 University of Graz

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
