<script setup lang='ts'>
import { computed, onMounted, ref } from 'vue'
import { NButton, NInput, NSpin, useMessage } from 'naive-ui'
// import { fetchChatConfig } from '@/api'
// import pkg from '@/../package.json'
// import { useAuthStore } from '@/store'
import type { UserInfo } from '@/store/modules/user/helper'
import { useUserStore } from '@/store'
import { t } from '@/locales'

// interface ConfigState {
//   timeoutMs?: number
//   reverseProxy?: string
//   apiModel?: string
//   socksProxy?: string
//   httpsProxy?: string
//   usage?: string
// }

// const authStore = useAuthStore()

const userStore = useUserStore()

const loading = ref(false)

// const config = ref<ConfigState>()

// const isChatGPTAPI = computed<boolean>(() => !!authStore.isChatGPTAPI)

const userInfo = computed(() => userStore.userInfo)
const gptKey = ref(userInfo.value.gptKey ?? '')
const ms = useMessage()
function updateUserInfo(options: Partial<UserInfo>) {
  userStore.updateUserInfo(options)
  ms.success(t('common.success'))
}
// async function fetchConfig() {
//   try {
//     loading.value = true
//     const { data } = await fetchChatConfig<ConfigState>()
//     config.value = data
//   }
//   finally {
//     loading.value = false
//   }
// }

onMounted(() => {

})
</script>

<template>
  <NSpin :show="loading">
    <div class="p-4 space-y-4">
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.gptkey') }}</span>
        <div class="flex-1">
          <NInput v-model:value="gptKey" placeholder="" />
        </div>
        <NButton size="tiny" text type="primary" @click="updateUserInfo({ gptKey })">
          {{ $t('common.save') }}
        </NButton>
      </div>
    </div>
  </NSpin>
</template>
