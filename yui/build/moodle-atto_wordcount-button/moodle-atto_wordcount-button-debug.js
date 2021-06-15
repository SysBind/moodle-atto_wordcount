YUI.add('moodle-atto_wordcount-button', function (Y, NAME) {

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
 * @copyright  2021 SysBind Ltd. <service@sysbind.co.il>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

/**
 * @module moodle-atto_wordcount-button
 */

/**
 * Atto text editor wordcount plugin.
 *
 * @namespace M.atto_wordcount
 * @class button
 * @extends M.editor_atto.EditorPlugin
 */


Y.namespace('M.atto_wordcount').Button = Y.Base.create('button', Y.M.editor_atto.EditorPlugin, [], {

    block: 0,
    update_rate: 200,
    counterid: null,
    countre: /[\w\u00C0-\u2013\u2015-\uFFDC]+/g,
    cleanre: /[\u2019\'-]*/g,
    update_on_delete: true,

    initializer: function () {
        var host = this.get('host');
        var wrapper = host._wrapper;
        this.counterid = host.get('elementId') + '-word-count';
        this.counterElement = Y.Node.create('<span class="badge badge-light" id="' + this.counterid + '">0</span>');
        wrapper.appendChild(
            Y.Node.create('<div class="' + this.toolbar.getAttribute('class') + ' p-0 d-flex">' +
                '<div class="bg-info col-1 text-center align-baseline pt-1"><strong>'
                + M.util.get_string('words', 'atto_wordcount') + ':' +
                '</strong><span class="badge badge-light" id="' + this.counterid + '">0</span>' +
                '<span class="sr-only">words count</span></div>' +
                '</div></div>'));
        this.get('host').on('pluginsloaded', function() {
            // Adds the current value to the stack.
            this.get('host').on('atto:selectionchanged', this._count, this);
        }, this);
    },
    _count: function (editor) {
        var wordcount = this;
        if (wordcount.block) {
            return;
        }

        wordcount.block = 1;
        setTimeout(function () {
            Y.one('#' + wordcount.counterid).set('text', wordcount._getCount(editor));
            setTimeout(function () {
                wordcount.block = 0;
            }, wordcount.update_rate);
        });
    },
    _getCount: function () {
        var wordCounts = 0;
        var editorText = this.get('host').getCleanHTML();
        if (editorText) {
            editorText = editorText.replace(/\.\.\./g, ' ');
            editorText = editorText.replace(/<.[^<>]*?>/g, ' ').replace(/&nbsp;|&#160;/gi, ' '); // remove html tags and space chars

            // deal with html entities
            editorText = editorText.replace(/(\w+)(&.+?;)+(\w+)/, "$1$3").replace(/&.+?;/g, ' ');
            // Replace underscores (which are classed as word characters) with spaces.
            editorText = editorText.replace(/_/g, ' ');
            // Remove any characters that shouldn't be treated as word boundaries.
            editorText = editorText.replace(this.cleanre, '');
            // Remove dots and commas from within numbers only.
            editorText = editorText.replace(/([0-9])[.,]([0-9])/g, '$1$2');

            var wordArray = editorText.match(this.countre);
            if (wordArray) {
                wordCounts = wordArray.length;
            }
        }
        return wordCounts;
    }

});


}, '@VERSION@');
