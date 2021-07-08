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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
    crossorigin="anonymous"></script>
  <title>赤ちゃん履歴</title>
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
    })
  </script>
</head>

<body>
  <div class="container">
    <h1 class="center-block mb-5"><a href="./">赤ちゃん履歴</a></h1>
    <div class="mb-3">
      <form action="./action_add.php" method="post">
        <div class="row">
          <div class="col">
            <select class="form-select type_id" name="type_id">
              {foreach from=$type_list item=i name=loop}
              <option value="{$i.type_id}">{$i.name}</option>
              {/foreach}
            </select>
          </div>
          <div class="col">
            <select class="form-select subtype_id" name="subtype_id" id="subtype_id">
              <option value="0">選択</option>
              {foreach from=$subtype_list item=i name=loop}
              <option value="{$i.subtype_id}" data-type_id="{$i.type_id}">{$i.name}</option>
              {/foreach}
            </select>
          </div>
          <div class="col">
            <button type="submit" class="btn btn-primary">追加</button>
          </div>
        </div>
      </form>
    </div>

    <hr>

    <form action="./" method="GET">
      <div class="row mb-3">
        <div class="col">
          <select class="form-select" name="type_id">
            <option value="0">未選択</option>
            <option value="999" {if $type_id==999} selected{/if}>乳全般</option>
            {foreach from=$type_list item=i name=loop}
            <option value="{$i.type_id}" {if $type_id==$i.type_id} selected{/if}>{$i.name}</option>
            {/foreach}
          </select>
        </div>
        <div class="col">
          <button type="submit" class="btn btn-primary">検索</button>
        </div>
      </div>
    </form>

    {foreach from=$timing_list item=i name=loop}
    {if $smarty.foreach.loop.first}
    <table class="table table-striped">
      <tr>
        <th>時間</th>
        <th>履歴</th>
        <th>操作</th>
      </tr>
      {/if}
      <tr>
        <td>{$i.datetime|date_format:'%m/%d %H:%M'}</td>
        <td>{$i.type_name} {$i.subtype_name}</td>
        <td>
          <a class="btn btn-primary btn-sm" href="./edit.php?timing_id={$i.timing_id}">変更</a>
          <a class="btn btn-primary btn-sm" href="./action_delete.php?timing_id={$i.timing_id}"
            onclick="return confirm('削除してもよろしいですか？')">削除</a>
        </td>
      </tr>
      {if $smarty.foreach.loop.last}
    </table>
    {/if}
    {/foreach}

    {if $page_count}
    <nav aria-label="ページング" class="mb-5">
      <ul class="pagination justify-content-center">
        {section name=loop loop=$page_count}
        {if $smarty.section.loop.iteration > $page_now - 4 && $smarty.section.loop.iteration < $page_now + 4}
        <li {if $smarty.section.loop.iteration==$page_now}class="page-item active" aria-current="page"
          {else}class="page-item" {/if}><a class="page-link"
            href="./?page={$smarty.section.loop.iteration}&type_id={$type_id}">{$smarty.section.loop.iteration}</a></li>
        {/if}
        {/section}
      </ul>
    </nav>
    {/if}
    <div id="xdomain_ad_120x240"></div>
  </div>
</body>

</html>