class ImperaviInput
  constructor: (el)->
    @el = $ el 
    @el.redactor
      focus: true
      imageUpload: '/admin/pictures'
      imageManagerJson: '/admin/pictures.json'
      fileUpload: '/admin/attachments'
      fileManagerJson: '/admin/attachments.json'
      buttons: ['html', 'formatting', 'bold', 'italic', 'deleted',
                'unorderedlist', 'orderedlist', 'outdent', 'indent',
                'image', 'file', 'link', 'alignment', 'horizontalrule']
      plugins: ['table', 'imagemanager', 'filemanager']
      buttonSource: true    
      changeCallback: =>
        @el.trigger "change"

window.addComponent ImperaviInput, className: 'imperavi-input'
