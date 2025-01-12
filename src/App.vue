<script setup>
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'
import { ref, getCurrentInstance } from 'vue'

const count = ref(0)
const getCount = getCurrentInstance()

// 添加错误处理器
getCount.appContext.app.config.errorHandler = (err) => {
  if (err.message === '计数不能超过10！') {
    count.value = 0  // 重置计数
    alert('计数已达到上限，已重置为0！')
  } else {
    console.error(err)  // 其他错误正常输出到控制台
  }
}

// 添加震动函数
const vibrate = () => {
  if (navigator.vibrate) {
    navigator.vibrate(50)  // 震动50毫秒
  }
}

const increment = () => {
  if (count.value >= 10) {
    // 错误时震动更长时间
    if (navigator.vibrate) {
      navigator.vibrate([100, 50, 100])  // 震动-暂停-震动 模式
    }
    throw new Error('计数不能超过10！')
  }
  count.value++
  vibrate()  // 普通点击时的震动
  console.log(`计数器增加到: ${count.value}`)
}
const msg = "hahssfd f  "

// 添加一些响应式变量作为示例
const width = ref(125)               // 用于动态绑定宽度
const height = ref(125)               // 用于动态绑定宽度
const isError = ref(false)               // 用于动态绑定 class
</script>

<template>
  <header>
    <img 
      alt="Vue logo" 
      class="logo" 
      src="./assets/logo.svg" 
      :width
      :height   
      @click="increment"
    
    />
    <!-- 简写语法：等同于 :width="width" -->
    <!-- 
      v-bind 指令用于动态绑定属性:
      1. 完整语法: v-bind:attribute="value"
      2. 简写语法: :attribute="value"
      
      常见用法:
      - 绑定 src: :src="imageUrl"
      - 绑定 class: :class="{ active: isActive }"
      - 绑定 style: :style="{ color: textColor }"
      - 绑定多个值: :style="[baseStyles, overrideStyles]"
      
      这里我们使用 :width 和 :height 来动态绑定图片尺寸
      当 width 或 height 的值改变时,图片尺寸会自动更新
    -->
      <!-- 
      v-on:click 指令用于监听 DOM 事件:
      1. 完整语法: v-on:click="handler"
      2. 简写语法: @click="handler"
      
      常见用法:
      - 调用方法: @click="increment"
      - 内联语句: @click="count++"
      - 传递参数: @click="increment(123)"
      - 访问事件对象: @click="(event) => handleClick(event)"
      
      这里我们使用 @click="increment" 来监听点击事件
      当图片被点击时,会调用 increment 方法增加计数
    -->
    <button 
      @click="increment"
      :class="{ 'error-state': isError }"
    >
      Increment：{{ count }}
    </button>

    <span>message: {{ msg }} </span>
    <div class="wrapper">
      <HelloWorld msg="You did it!" />
    </div>
  </header>
  <main>
    <TheWelcome />
  </main>
</template>




<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
  cursor: pointer;
  transition: transform 0.2s;
}
.logo:hover {
  transform: scale(1.05);
  filter: brightness(1.1);
}
.logo:active {
  transform: scale(0.95);
  filter: brightness(1.2);
}
/* 
当为图片添加点击事件时,我们可以添加一些动态效果来增强交互体验:

1. 使用 transition 添加过渡效果:
   - transform: scale() 实现缩放
   - opacity 实现透明度变化
   - filter: brightness() 实现亮度变化

2. 使用伪类实现交互状态:
   - :hover - 鼠标悬停效果
   - :active - 点击时的效果
   
3. 常见的动态效果组合:
   .img-clickable {
     cursor: pointer;
     transition: all 0.2s;
   }
   .img-clickable:hover {
     transform: scale(1.05);
     filter: brightness(1.1);
   }
   .img-clickable:active {
     transform: scale(0.95);
   }
*/

.increment-btn {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }
  .increment-btn {
    position: absolute;
    top: 145px;  /* 调整这个值可以控制按钮与图片的距离 */
    left: 50%;
    transform: translateX(-50%);  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}

.error-state {
  background-color: #ff5555;
  color: white;
}
</style>
