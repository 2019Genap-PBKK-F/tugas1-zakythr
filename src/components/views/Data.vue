
<template>
  <div>
    <div id="app" ref="spreadsheet"></div>
    <div><input type="button" value="Add new row" @click="() => spreadsheet.insertRow()" /></div>
  </div>
</template>

<script>
import jexcel from 'jexcel'
import 'jexcel/dist/jexcel.css'
var data = [
  ['05111740000140', 'Zaky', '2017', '1999-06-04', '', true],
  ['05111740000141', 'Aurelia', '2017', '1999-06-12', '', true]
]
var options = {
  data: data,
  allowToolbar: true,
  columns: [
    { type: 'text', title: 'NRP', width: '120px' },
    { type: 'text', title: 'Nama', width: '250px' },
    { type: 'text', title: 'Angkatan', width: '250px' },
    { type: 'calendar', title: 'Tgl Lahir', width: '120px' },
    { type: 'image', title: 'Photo', width: '80px' },
    { type: 'checkbox', title: 'Aktif', width: '80px' }
  ]
}
export default {
  name: 'App',
  mounted: function () {
    let spreadsheet = jexcel(this.$el, options)
    Object.assign(this, { spreadsheet })
  }
}
</script>
