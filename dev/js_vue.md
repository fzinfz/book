<!-- TOC -->

- [Vite](#vite)
- [V3](#v3)
  - [2to3](#2to3)
- [createApp](#createapp)
  - [hydration mode](#hydration-mode)
- [Components](#components)
  - [defineComponent](#definecomponent)
  - [defineCustomElement](#definecustomelement)
- [Plugins](#plugins)
- [Routing](#routing)
- [VNode - h()](#vnode---h)
- [Data Binding](#data-binding)
  - [v-bind/on](#v-bindon)
  - [computed](#computed)
  - [refs](#refs)
- [List Rendering](#list-rendering)
- [lifecycle](#lifecycle)
- [Code Snippets](#code-snippets)

<!-- /TOC -->

# Vite
https://vitejs.dev/guide/why.html

https://vitejs.dev/guide/

    # vanilla, vanilla-ts, vue, vue-ts, react, react-ts ...
    npm create vite@latest test-vue3-ts-vite --template vue-ts    # npm 6.x
    npm create vite@latest test-vue3-ts-vite -- --template vue-ts # npm 7+
    npm install && npm run dev

[README.md](https://github.com/fzinfz/test-vue3-ts-vite/blob/0652a5ecc9440d520021e4c023fdc21da547efa2/README.md): `@builtin vscode.typescript-language-features` -> `Disable (Workspace)` | install `vue.volar` + `Vue.vscode-typescript-vue-plugin`

# V3

    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    const { createApp } = Vue

    <script type="module">
      import { createApp } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js'

## 2to3
https://vuejsdevelopers.com/2020/03/16/vue-js-tutorial/

- `new Vue()` ====> `createApp()`
- `data: {`   ====> `data: () => ({`
- `render: h => h(App)` ====> `App`
- multi `<>` under `<template>`
- `setup()`: no `.value` and `this` : https://vuejs.org/api/composition-api-setup.html
- Teleport: `<Teleport to="body/#id">`: https://vuejs.org/guide/built-ins/teleport.html
- 
# createApp

    Vue.createApp({
        data() {
            return {
                items: ...
            }
        }
    }).mount('#id')

源码 - ensureRenderer: https://vue3js.cn/global/createApp.html

https://vuejs.org/api/application.html#createapp

    function createApp(rootComponent: Component, rootProps?: object): App

## hydration mode
https://vuejs.org/guide/scaling-up/ssr.html#client-hydration

make the client-side app interactive: use createSSRApp() instead of createApp()

shared between the server and the client - universal code:

    export function createApp() {
        return createSSRApp({

# Components
.vue - Single-File Component/SFC: https://vuejs.org/guide/essentials/component-basics.html

```
<script>
import ButtonCounter from './ButtonCounter.vue'

export default {
  components: {
    ButtonCounter
  }
}
</script>

<template>
  <h1>Here is a child component!</h1>
  <ButtonCounter />
</template>
```

## defineComponent

    import { defineComponent } from 'vue'

    const MyComponent = defineComponent({
        data() {
        methods: {

## defineCustomElement

    import { defineCustomElement } from 'vue'
    const MyVueElement = defineCustomElement({
    customElements.define('my-vue-element', MyVueElement)

    <my-vue-element></my-vue-element>

# Plugins
https://vuejs.org/guide/reusability/plugins.html

    app.use(myPlugin, { })

    const myPlugin = {
        install(app, options) {

    export default {
        install: (app, options) => {

# Routing
https://vuejs.org/guide/scaling-up/routing.html

# VNode - h()
https://vuejs.org/guide/extras/render-function.html

    import { h } from 'vue'
    h('div', { id: 'foo' }, 'hello')

# Data Binding
## v-bind/on
v-bind: https://vuejs.org/guide/essentials/template-syntax.html#dynamically-binding-multiple-attributes

    data() {
        return {
            objectOfAttrs: {

    <div v-bind="objectOfAttrs"></div>

v-bind : 1-way
v-model: 2-way = v-bind + v-on

    <a v-bind:href="url"> ... </a>          ==>  <a :href=""> ... </a>
    <a v-on:click="doSomething"> ... </a>   ==>  <a @click=""> ... </a>

## computed
for complex logic that includes reactive data：https://vuejs.org/guide/essentials/computed.html

## refs
https://vuejs.org/guide/essentials/template-refs.html

    <input ref="input">

    this.$refs.input.focus()

# List Rendering
https://v3.vuejs.org/guide/list.html

# lifecycle
https://v3.vuejs.org/guide/instance.html#creating-an-application-instance
![](https://v3.vuejs.org/images/lifecycle.svg)

# Code Snippets
* str(lines) -> html(links): https://github.com/fzinfz/fzinfz.github.io/blob/master/i/index.html
