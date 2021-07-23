<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="theme-color" content="#000000">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"
    integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
    integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/wickedpicker@0.4.3/dist/wickedpicker.min.css">
  <script src="https://cdn.jsdelivr.net/npm/wickedpicker@0.4.3/dist/wickedpicker.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
    crossorigin="anonymous"></script>
  <title>赤ちゃん履歴変更</title>
  <script>
    $(function () {
      var subtype_list = $('#subtype_id option').clone();
      $('.type_id').change(function () {
        var type_id = $(this).val();
        var subtype = $(this).parent().parent().find('.subtype_id');
        var selected = subtype.find('option:selected').val();
        subtype.find('option').remove();
        subtype.append($('<option>').html('選択').val('0'));
        subtype_list.each(function () {
          if ($(this).data('type_id') == type_id) {
            if ($(this).val() == selected) {
              subtype.append($('<option>').html($(this).html()).val($(this).val()).prop('selected', true));
            } else {
              subtype.append($('<option>').html($(this).html()).val($(this).val()));
            }
          }
        });
      });
      $('.type_id').trigger('change');
      $('#date').datepicker({
        dateFormat: 'yy/mm/dd'
      });
      $('#time').wickedpicker({
        now: '{$timing.datetime|date_format:"%H:%M"}',
        twentyFour: true
      });
    })
  </script>
</head>

<body>
  <div class="container">
    <h1 class="center-block mb-5">赤ちゃん履歴変更</h1>
    <div class="mb-3">
      <a class="btn btn-primary" href="javascript:history.back();">戻る</a>
    </div>
    <div class="mb-3">
      <form action="./action_edit.php" method="post">
        <input type="hidden" name="timing_id" value="{$timing.timing_id}">
        <div class="row mb-3">
          <div class="col">
            <input type="text" class="form-control" id="date" name="date"
              value="{$timing.datetime|date_format:'%Y/%m/%d'}">
          </div>
          <div class="col">
            <input type="text" class="form-control" id="time" name="time"
              value="">
          </div>
        </div>
        <div class="row mb-3">
          <div class="col">
            <select class="form-select type_id" name="type_id">
              {foreach from=$type_list item=i name=loop}
              <option value="{$i.type_id}" {if $timing.type_id==$i.type_id} selected{/if}>{$i.name}</option>
              {/foreach}
            </select>
          </div>
          <div class="col">
            <select class="form-select subtype_id" name="subtype_id" id="subtype_id">
              <option value="0">選択</option>
              {foreach from=$subtype_list item=i name=loop}
              <option value="{$i.subtype_id}" data-type_id="{$i.type_id}" {if $timing.subtype_id==$i.subtype_id}
                selected{/if}>{$i.name}</option>
              {/foreach}
            </select>
          </div>
        </div>
        <button type="submit" class="btn btn-primary">変更</button>
      </form>
    </div>
    <div id="xdomain_ad_120x240"></div>
  </div>
</body>

</html>