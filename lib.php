<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * atto_wordcount lib file.
 *
 * @package    atto_wordcount
 * @copyright  Avi Levy <avi@sysbind.co.il>
 *             2022 André Menrath <andre.menrath@uni-graz.at>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */


/**
 * Initialise the js strings required for this module.
 */
function atto_wordcount_strings_for_js() {
    global $PAGE;

    $PAGE->requires->strings_for_js(['words', 'wordscount'], 'atto_wordcount');
}


/**
 * Pass the wordlimits to the js part of the plugin.
 *
 * @return array $params.
 */
function atto_wordcount_params_for_js() {
    $wordlimits = atto_wordcount\wordlimit::get_wordlimits();
    // Wrapp the wordlimits into an array whith wordlimits as the key.
    $params = array ( 'wordlimits' => $wordlimits );
    return $params;
}
