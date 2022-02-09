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

/*
 * @package    atto_wordcount
 * @copyright  2021 Avi Levy <avi@sysbind.co.il>0
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

/**
 * @module moodle-atto_wordcount-button
 */

/**
 * Atto text editor wordcount plugin.
 * @package    atto_wordcount
 * @copyright  2021 Avi Levy <avi@sysbind.co.il>
 *             2022 André Menrath <andre.menrath@uni-graz.at>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 * @namespace  M.atto_wordcount
 * @class      button
 * @extends    M.editor_atto.EditorPlugin
 */


// Global Variable which keeps track if more than one editor is on page, as possible inside a quiz.
var editorInstance = 0;

Y.namespace('M.atto_wordcount').Button = Y.Base.create('button', Y.M.editor_atto.EditorPlugin, [], {

    block: 0,
    updateRate: 200,
    counterid: null,
    spacer: /(<\/(?!a>|b>|del>|em>|i>|ins>|s>|small>|strong>|sub>|sup>|u>)\w+>|<br> | <br\s*\/>)/g,
    mediaTags: /(<(audio|video)).*(<\/(audio|video)>)/gm,
    counter: new RegExp('[\\p{Z}\\p{Cc}—–]+', 'gu'),

    initializer: function() {
        var host = this.get('host');
        var wrapper = host._wrapper;
        this.counterid = host.get('elementid') + '-word-count';
        this.counterid = this.counterid.replace(':', '-');
        this.counterElement = Y.Node.create('<span class="badge badge-light" id="' + this.counterid + '">0</span>');
        wrapper.appendChild(
            Y.Node.create('<div class="' + this.toolbar.getAttribute('class') + ' editor_atto_toolbar_bottom p-0 d-flex">' +
                '<div class="d-inline-flex p-1"><strong>'
                + M.util.get_string('words', 'atto_wordcount') + ': ' +
                '</strong><span id="' + this.counterid + '">0</span>' +
                '</div></div>'));
        this.wordlimit = this.get('wordlimits')[editorInstance];
        if (this.wordlimit) {
            window.console.log('here');
            var warningIcon = document.createElement("i");
            warningIcon.classList.add('icon', 'fa', 'fa-exclamation', 'fa-fw');
            warningIcon.id = this.counterid + '-warning-icon';
            document.getElementById(this.counterid).parentNode.insertBefore(warningIcon, document.getElementById(this.counterid));
            var seperatorField = document.createElement('span');
            seperatorField.innerHTML = '/';
            document.getElementById(this.counterid).parentNode.appendChild(seperatorField);
            var wordLimitField = document.createElement('span');
            wordLimitField.innerHTML = this.wordlimit;
            document.getElementById(this.counterid).parentNode.appendChild(wordLimitField);
        }
        editorInstance += 1;
        this._count(host.get('editor'));
        this.get('host').on('pluginsloaded', function() {
            // Adds the current value to the stack.
            this.get('host').on('atto:selectionchanged', this._count, this);
        }, this);
    },
    _count: function(editor) {
        var wordcount = this;
        if (wordcount.block) {
            return;
        }

        wordcount.block = 1;
        setTimeout(function() {
            var currentCount = wordcount._getCount(editor);
            Y.one('#' + wordcount.counterid).set('text', currentCount);
            if (wordcount.wordlimit) {
                if (wordcount.wordlimit - currentCount < 0) {
                    Y.one('#' + wordcount.counterid + '-warning-icon').setStyle("display", "inline");
                } else {
                    Y.one('#' + wordcount.counterid + '-warning-icon').setStyle("display", "none");
                }
            }
            // if (wordcount.wordlimit) {
            //     if (wordcount.wordlimit - currentCount < 0) {
            //         Y.one('#' + wordcount.counterid).addClass('danger');
            //         Y.one('#' + wordcount.counterid).removeClass('warning');
            //     } else if (wordcount.wordlimit - currentCount < 10) {
            //         Y.one('#' + wordcount.counterid).addClass('warning');
            //         Y.one('#' + wordcount.counterid).removeClass('danger');
            //     } else {
            //         Y.one('#' + wordcount.counterid).removeClass('warning');
            //         Y.one('#' + wordcount.counterid).removeClass('danger');
            //     }
            // }
            setTimeout(function() {
                wordcount.block = 0;
            }, wordcount.updateRate);
        });
    },
    _getCount: function() {
        var wordCounts = 0;
        var editorText = this.get('host').getCleanHTML();
        if (editorText) {
            editorText = editorText.replace(this.spacer, '$1 ');
            editorText = editorText.replace(/<.[^<>]*?>/g, '');
            editorText = editorText.replace(/&nbsp;|&#160;/gi, ' ');
            var wordArray = editorText.split(this.counter, -1);
            wordArray = wordArray.filter(function(entry) {
                return entry.trim() != '';
            });
            if (wordArray) {
                wordCounts = wordArray.length;
            }
        }
        return wordCounts;
    }

}, {
    ATTRS: {
        /**
         * Whether or not to allow borders
         *
         * @attribute wordlimits
         * @type Array
         */
        wordlimits: {
            value: [0]
        },
    }
}
);
