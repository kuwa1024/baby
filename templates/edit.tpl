{extends file='layout.tpl'}
{block name=title}赤ちゃん履歴変更{/block}
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
    $('#date').datepicker({
      dateFormat: 'yy/mm/dd'
    });
    $('#time').wickedpicker({
      now: '{$timing.datetime|date_format:"%H:%M"}',
      twentyFour: true
    });
  })
</script>
{/block}
{block name=body}
<div class="container">
  <h1 class="center-block mb-5">赤ちゃん履歴変更</h1>
  <div class="mb-3">
    <a class="btn btn-primary" href="javascript:history.back();">戻る</a>
  </div>
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
    <form action="/edit/{$timing.timing_id}" method="POST">
      <div class="row mb-3">
        <div class="col">
          <input type="text" class="form-control" id="date" name="date"
            value="{$timing.datetime|date_format:'%Y/%m/%d'}">
        </div>
        <div class="col">
          <input type="text" class="form-control" id="time" name="time" value="">
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
{/block}