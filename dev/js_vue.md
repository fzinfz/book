<!-- TOC -->

- [V3](#v3)
- [Vue.createApp](#vuecreateapp)
- [v-bind/on](#v-bindon)
- [List Rendering](#list-rendering)
- [lifecycle](#lifecycle)
- [Code Snippets](#code-snippets)

<!-- /TOC -->

# V3

    <script src="https://unpkg.com/vue@next"></script>

# Vue.createApp

    Vue.createApp({
        data() {
            return {
                items: ...
            }
        }
    }).mount('#id')

# v-bind/on

    v-bind : 1-way
    v-model: 2-way = v-bind + v-on

    <a v-bind:href="url"> ... </a>          ==>  <a :href=""> ... </a>
    <a v-on:click="doSomething"> ... </a>   ==>  <a @click=""> ... </a>


# List Rendering
https://v3.vuejs.org/guide/list.html

# lifecycle
https://v3.vuejs.org/guide/instance.html#creating-an-application-instance
![](https://v3.vuejs.org/images/lifecycle.svg)

# Code Snippets
* str(lines) -> html(links): https://github.com/fzinfz/fzinfz.github.io/blob/master/i/index.html
