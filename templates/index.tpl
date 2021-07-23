{extends file='layout.tpl'}
{block name=title}赤ちゃん履歴{/block}
{block name=head}
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
{/block}
{block name=body}
<div class="container">
  <h1 class="center-block mb-5"><a href="/">赤ちゃん履歴</a></h1>
  {if $err_msg|is_array}
  <div class="alert alert-danger" role="alert">
    {foreach from=$err_msg item=i}
    {foreach from=$i item=j}
    {$j}<br>
    {/foreach}
    {/foreach}
  </div>
  {/if}
  <div class="mb-3">
    <form action="./add" method="POST">
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

  {foreach from=$timing_list item=i}
  {if $i@first}
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
        <a class="btn btn-primary btn-sm" href="./edit/{$i.timing_id}">変更</a>
        <a class="btn btn-primary btn-sm" href="./delete/{$i.timing_id}"
          onclick="return confirm('削除してもよろしいですか？')">削除</a>
      </td>
    </tr>
    {if $i@last}
  </table>
  {/if}
  {/foreach}

  {if $page.links|is_array}
  <nav aria-label="ページング" class="mb-5">
    <ul class="pagination justify-content-center">
      {foreach from=$page.links item=i}
      <li {if $i.this}class="page-item active" aria-current="page" {else}class="page-item" {/if}>
        <a class="page-link" href="{$i.url}">{$i.page}</a>
      </li>
      {/foreach}
    </ul>
  </nav>
  {/if}
</div>
{/block}