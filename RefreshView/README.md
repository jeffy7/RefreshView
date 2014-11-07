# RefreshView
=====================
## 一个集成异常处理下拉刷新上拉加载的控件

* **ExecptionView**           处理异常
* **LoadFooterView**          上拉加载
* **RefreshHeaderView**       刷新视图

* **BaseListView**            集合刷新加载异常处理的基本视图



### 基本思想

三个基本视图都集合在一个基本视图里面，在BaseView里面处理各种逻辑的代理。而BaseView是通用View,适用于有TableView需要刷新的界面。

### 用法

相当简单，继承与BaseView，重写三种视图的代理

### 补充

异常处理有很多种，时间有限，就没能全部列举，写的很零散，也没时间校对，有时间发现问题再修复。
