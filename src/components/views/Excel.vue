<template>
  <section class="content">
    <div class="row center-block">
      <h1 class="text-center">Data Mahasiswa</h1>
      <input type="button" value="Add New Row" @click="() => spreadsheet.insertRow()" />
      <input type="button" value="Delete Selected Row" @click="() => spreadsheet.deleteRow()" />
      <div id="app" ref="spreadsheet"></div>
    </div>
  </section>
</template>

<script>
import jexcel from 'jexcel'
import 'jexcel/dist/jexcel.css'
import axios from 'axios'
var data = []

var update = function (obj, cel, y, x, val) {
  x = parseInt(x)
  y = parseInt(y)
  axios({
    method: 'get',
    url: 'http://localhost:3000/siswa/'
  }).then(response => {
    var data = Object.values(response.data[x])
    console.log(response.data)
    data[y] = val
    var tmpData = data
    axios.put('http://localhost:3000/siswa/' + tmpData[0], {
      id: tmpData[0],
      nrp: tmpData[1],
      nama: tmpData[2],
      angkatan: tmpData[3],
      tgl_lahir: tmpData[4],
      photo: tmpData[5],
      aktif: tmpData[6]
    }).then(response => {
      // console.log(response.data)
    })
  })
}

var deleterow = function(obj, x) {
  axios({
    method: 'get',
    url: 'http://localhost:3000/siswa/'
  }).then(response => {
    var index = Object.values(response.data[x])
    console.log(x)
    axios.delete('http://localhost:3000/siswa/' + index[0])
  })
}

var newRow = function() {
  axios({
    method: 'post',
    url: 'http://localhost:3000/siswa/'
  }).then(response => {
    console.log(response.data)
  })
}

var options = {
  data: data,
  url: 'http://localhost:3000/siswa/',
  onchange: update,
  oninsertrow: newRow,
  ondeleterow: deleterow,
  defaultColWidth: 100,
  tableOverflow: true,
  tableWidth: '1000px',
  allowToolbar: false,
  allowInsertRow: true,
  allowDeleteRow: true,
  columns: [
    { type: 'hidden', title: 'ID', width: '80px' },
    { type: 'text', title: 'NRP', width: '200px' },
    { type: 'text', title: 'Nama', width: '250px' },
    { type: 'text', title: 'Angkatan', width: '100px' },
    { type: 'calendar', title: 'Tanggal Lahir', width: '120px' },
    { type: 'image', title: 'Photo', width: '120px' },
    { type: 'checkbox', title: 'Aktif', width: '80px' }
  ]
}

export default {
  name: 'App',
  data() {
    return {
      siswa: [],
      form: {
        id: '',
        nrp: '',
        nama: '',
        angkatan: '',
        tgl_lahir: '',
        foto: '',
        aktif: ''
      }
    }
  },
  mounted: function () {
    axios.get('http://localhost:3000/siswa/').then(response => {
      console.log(response.data)
      let spreadsheet = jexcel(this.$el, options)
      Object.assign(this, { spreadsheet })
    })
  }
}
</script>
