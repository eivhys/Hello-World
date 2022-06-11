import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="monaco"

export default class extends Controller {
  static targets = ['codeEditor']

  connect() {
    this.editor = this.initiateCodeEditor()
  }

  onChange() {
    document.getElementById(
      document.getElementById('codeEditor').dataset.monacoTarget
    ).value = this.editor.getValue()
  }

  initiateCodeEditor() {
    return monaco.editor.create(document.getElementById('codeEditor'), {
      value: "def solution(n):\n  # implement your solution here!\nend",
      language: document.getElementById('codeEditor').dataset.lang,
      theme: 'hc-black',
      lineNumbers: 'on',
      vertical: 'auto',
      horizontal: 'auto',
      tabSize: 2,
      minimap: {
        enabled: false
      },
      overviewRulerLanes: 0,
      hideCursorInOverviewRuler: true,
      overviewRulerBorder: false,
    })
  }

  dataTarget() {
    console.log(document.getElementById('codeEditor').dataset.monacoTarget)
  }

  codeEditor() {
    return parseInt(this.codeEditorTarget)
  }
}
