<!-- TOC -->

- [vue](#vue)
  - [vxe-table](#vxe-table)
  - [matfish2/vue-tables](#matfish2vue-tables)
- [jquery](#jquery)
  - [jexcel](#jexcel)
- [standalone](#standalone)
- [HTML Table](#html-table)

<!-- /TOC -->

- TanStack - React, Solid, Vue, Svelte and TS/JS: https://github.com/TanStack/table#tanstack-table-v8
- AG Grid - Supports React / Angular / Vue / Plain JavaScript: https://github.com/ag-grid/ag-grid
- S2 - 多维交叉分析: https://github.com/antvis/s2/#s2
- Antd Table: https://ant.design/components/table-cn
- ProTable: https://procomponents.ant.design/en-US/components/table?current=1&pageSize=5

https://github.com/FancyGrid/awesome-grid

# vue
## vxe-table
https://vxetable.cn/#/table/start/install

- CDN: https://vxetable.cn/#/table/start/install
- `npm install xe-utils vxe-table@next` # better for webpack、vite

js/ts/setup()/JSX: https://vxetable.cn/#/table/start/quick

support tree table: https://vxetable.cn/#/table/advanced/search

## matfish2/vue-tables
https://raw.githubusercontent.com/matfish2/vue-tables/master/dist/vue-tables.min.js

Demo: https://jsfiddle.net/matfish2/jfa5t4sm/
Feature: expand row to multi-rows

# jquery
## jexcel
https://github.com/paulhodel/jexcel

roadmap: Online work collaboration

# standalone
- tabulator: https://github.com/olifolkerd/tabulator  

# HTML Table
https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table

    <table>
        <thead>
            <tr>
                <th colspan="2">The table header</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>The table body</td>
                <td>with two columns</td>
            </tr>
        </tbody>
    </table>

    <table>
        <thead>
            <tr>
                <th>Items</th>
                <th scope="col">Expenditure</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th scope="row">Donuts</th>
                <td>3,000</td>
            </tr>
            <tr>
                <th scope="row">Stationery</th>
                <td>18,000</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <th scope="row">Totals</th>
                <td>21,000</td>
            </tr>
        </tfoot>
    </table>