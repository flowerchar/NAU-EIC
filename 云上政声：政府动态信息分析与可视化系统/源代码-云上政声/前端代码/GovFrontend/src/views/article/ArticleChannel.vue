<script setup>
import PageContainer from '@/components/PageContainer.vue'
import { artDelChannelService, artGetChannelService } from '@/api/article'
import { ref } from 'vue'
import { Delete, Edit } from '@element-plus/icons-vue'
import ChannelEdit from '@/views/article/components/ChannelEdit.vue'

const loading = ref(false)
const channelList = ref([])
const dialog = ref()
const getChannelList = async () => {
  loading.value = true
  const res = await artGetChannelService()
  channelList.value = res.data.data
  // console.log(channelList.value)
  loading.value = false
}
const onEditChannel = (row) => {
  dialog.value.open(row)
}
const onAddChannel = () => {
  dialog.value.open({})
}
const onDeleteChannel = async (row) => {
  await ElMessageBox.confirm('你确定要删除该分类吗', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  console.log('onDeleteChannel', row)
  await artDelChannelService(row.id)
  ElMessage.success('删除成功')
  getChannelList()
}
const onSuccess = () => {
  // console.log('success')
  getChannelList()
}
getChannelList()
</script>
