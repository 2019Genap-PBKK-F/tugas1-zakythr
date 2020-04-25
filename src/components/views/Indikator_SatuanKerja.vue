<template>
  <section class="content">
    <div class="row center-block">
      <h1 class="text-center">Indikator Satuan Kerja Log</h1>
      <input type="button" value="Add New Row" @click="() => spreadsheet.insertRow()" />
      <input type="button" value="Delete Selected Row" @click="() => spreadsheet.deleteRow()" />
      <div id="spreadsheet"></div>
    </div>
  </section>
</template>

<script>
import jexcel from 'jexcel'
import 'jexcel/dist/jexcel.css'
import axios from 'axios'
var update = function (obj, cel, y, x, val) {
  x = parseInt(x)
  y = parseInt(y)
  axios({
    method: 'get',
    url: 'http://localhost:8026/api/indikator_satuan/'
  }).then(response => {
    var data = Object.values(response.data[x])
    console.log(response.data)
    data[y] = val
    var tmpData = data
    axios.put('http://localhost:8026/api/indikator_satuan/' + tmpData[0], {
      id_periode: tmpData[0],
      id_master: tmpData[1],
      id_satker: tmpData[2],
      bobot: tmpData[3],
      targett: tmpData[4],
      capaian: tmpData[5],
      last_update: tmpData[6]
    }).then(response => {
      // console.log(response.data)
    })
  })
}
var deleterow = function(obj, x) {
  axios({
    method: 'get',
    url: 'http://localhost:8026/api/indikator_satuan/'
  }).then(response => {
    var index = Object.values(response.data[x])
    console.log(x)
    axios.delete('http://localhost:8026/api/indikator_satuan/' + index[0])
  })
}
var newRow = function() {
  axios({
    method: 'post',
    url: 'http://localhost:8026/api/indikator_satuan/'
  }).then(response => {
    console.log(response.data)
  })
}
// var options = {
//   data: data,
//   url: 'http://localhost:3000/siswa/',
//   onchange: update,
//   oninsertrow: newRow,
//   ondeleterow: deleterow,
//   defaultColWidth: 100,
//   tableOverflow: true,
//   tableWidth: '1000px',
//   allowToolbar: false,
//   allowInsertRow: true,
//   allowDeleteRow: true,
//   columns: [
//     { type: 'hidden', title: 'ID', width: '80px' },
//     { type: 'text', title: 'NRP', width: '200px' },
//     { type: 'text', title: 'Nama', width: '250px' },
//     { type: 'text', title: 'Angkatan', width: '100px' },
//     { type: 'calendar', title: 'Tanggal Lahir', width: '120px' },
//     { type: 'image', title: 'Photo', width: '120px' },
//     { type: 'checkbox', title: 'Aktif', width: '80px' }
//   ]
// }
export default {
  name: 'App',
  mounted: function () {
    this.load()
  },
  // data() {
  //   return {
  //     siswa: [],
  //     form: {
  //       id: '',
  //       nrp: '',
  //       nama: '',
  //       angkatan: '',
  //       tgl_lahir: '',
  //       foto: '',
  //       aktif: ''
  //     }
  //   }
  // },
  methods: {
    load() {
      axios.get('http://localhost:8026/api/indikator_satuan/').then(response => {
        console.log(response.data)
        var options = {
          data: response.data,
          onchange: update,
          oninsertrow: newRow,
          ondeleterow: deleterow,
          allowToolbar: true,
          columns: [
            { type: 'text', title: 'ID Periode', width: '150px' },
            { type: 'text', title: 'ID Master', width: '150px' },
            { type: 'text', title: 'ID Satker', width: '150px' },
            { type: 'text', title: 'Bobot', width: '100px' },
            { type: 'text', title: 'Target', width: '100px' },
            { type: 'text', title: 'Capaian', width: '100px' },
            { type: 'text', title: 'Last Update', width: '200px' }
          ]
        }
        let spreadsheet = jexcel(this.$el, options)
        Object.assign(this, { spreadsheet })
      })
    }
  }
}
</script>
