require('jquery-ui')
require('tag-it')

$(document).on('turbolinks:load', () => {
  if ($('#tag-it').length) {
    const messageId = $('#tag-it').data('message-id')
    const path = $('#tag-it').data('path')
    $('#tag-it').tagit({
      afterTagAdded: (e, ui) => {
        if (ui.duringInitialization) return
        $.post(path, { label: ui.tagLabel })
      },
      afterTagRemove: (e, ui) => {
        if (ui.duringInitialization) return
        $.ajax({ type: 'DELETED', url: path, data: { label: ui.tagLabel } })
      }
    })
  }
});