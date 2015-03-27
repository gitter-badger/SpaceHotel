# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  priceSlider = $('#price-slider').slider(
    min: 10
    max: 200
    range: true
    value: [10, 200]
    step: 1)
  sizeSlider = $('#size-slider').slider(
    min: 15
    max: 150
    range: true
    value: [15, 150]
    step: .5)
  occupancySlider = $('#occupancy-slider').slider(
    min: 1
    max: 8
    range: true
    value: [1, 8]
    step: 1)
  specificationChooser = $('.specification-chooser').data('ids', ->
    ids = ''
    $('.specification-chooser input').each ->
      if @checked then (ids += $(@).val() + ',') else ''
    ids
  )
  datarangePicker = $('#reportrange').daterangepicker({
      format: 'MM/DD/YYYY'
      startDate: moment()
      endDate: moment().add(1, 'days')
      minDate: moment()
      maxDate: moment().add(3, 'month')
      dateLimit: days: 60
      showDropdowns: true
      showWeekNumbers: true
      opens: 'left'
      buttonClasses: [
        'btn'
        'btn-sm'
      ]
      applyClass: 'btn-primary'
      cancelClass: 'btn-default'
      separator: ' to '
    }, (start, end, label) ->
    datarangePicker.data 'dates', start.format('MM/DD/YYYY') + '-' + end.format('MM/DD/YYYY')
    $('#reportrange span').html start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')
    filterrificRefresh()
  )
  $('#reportrange span').html moment().format('MMMM D, YYYY') + ' - ' + moment().add(1, 'days').format('MMMM D, YYYY')

  filterrificRefresh = ->
    url = $(this).parents('form').attr('action')
    $('.filterrific_spinner').show()
    $.ajax(
      url: url
      data: filterrific:
        with_specification: specificationChooser.data('ids')()
        with_date: datarangePicker.data('dates')
        with_price: priceSlider.val()
        with_size: sizeSlider.val()
        with_occupancy: occupancySlider.val()
        sort_dy: $('#sort_by').val()
      type: 'GET'
      dataType: 'script').done (msg) ->
    $('.filterrific_spinner').hide()

  $('.specification-chooser input, #sort_by').on 'change', filterrificRefresh
  $('.filterrific-sliders input').on 'slideStop', filterrificRefresh