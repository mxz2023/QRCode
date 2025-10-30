// 定义内容项接口
interface ContentItem {
  title: string;
  time: string;
}

@Entry
@Component
struct ContentPage {
  @State currentTab: number = 0;
  @State selectedFilter: number = 1;

  // 模拟数据
  private contentItems: ContentItem[] = [
    { title: "设计灵感", time: "今天更新" },
    { title: "开发技巧", time: "昨天更新" },
    { title: "最佳实践", time: "2天前更新" },
    { title: "UI组件", time: "今天更新" },
    { title: "性能优化", time: "昨天更新" },
    { title: "安全指南", time: "2天前更新" },
    { title: "测试方法", time: "今天更新" },
    { title: "部署策略", time: "昨天更新" },
    { title: "监控工具", time: "2天前更新" },
    { title: "文档规范", time: "今天更新" },
    { title: "团队协作", time: "昨天更新" },
    { title: "版本管理", time: "2天前更新" }
  ];

  // 过滤器标签
  private filterLabels: string[] = ["全部", "设计", "开发", "测试", "部署", "文档", "团队", "工具", "安全", "性能"];

  build() {
    Column() {
      // 状态栏
      this.StatusBar()
      
      // 标题栏
      this.TitleBar()
      
      // 过滤器标签栏
      this.FilterBar()
      
      // 操作按钮区域
      this.ActionButtons()
      
      // 内容网格
      this.ContentGrid()
      
      // 底部导航栏
      this.BottomNavigation()
      
      // 底部指示器
      this.BottomIndicator()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FEF7FF')
  }

  // 状态栏组件
  @Builder StatusBar() {
    Row() {
      Text('9:30')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D1B20')
        .margin({ left: 24, top: 22 })
      
      Row() {
        Text('📶')
          .fontSize(14)
        Text('📡')
          .fontSize(14)
          .margin({ left: 16 })
        Text('🔋')
          .fontSize(15)
          .margin({ left: 22 })
      }
      .width(46)
      .height(17)
      .margin({ right: 24, top: 25 })
      .justifyContent(FlexAlign.End)
      
      Text('📱')
        .fontSize(16)
        .margin({ top: 18 })
        .align(Alignment.Center)
    }
    .width('100%')
    .height(52)
    .backgroundColor('#FEF7FF')
  }

  // 标题栏组件
  @Builder TitleBar() {
    Row() {
      // 左侧头像按钮
      Button({ type: ButtonType.Circle }) {
        Text('👤')
          .fontSize(24)
      }
      .width(48)
      .height(48)
      .backgroundColor('#FEF7FF')
      .margin({ left: 4, top: 8 })

      // 标题
      Text('内容中心')
        .fontSize(22)
        .fontWeight(FontWeight.Normal)
        .fontColor('#1D1B20')
        .margin({ left: 12, top: 18 })
        .layoutWeight(1)

      // 右侧搜索按钮
      Button({ type: ButtonType.Circle }) {
        Text('🔍')
          .fontSize(24)
      }
      .width(48)
      .height(48)
      .backgroundColor('#FEF7FF')
      .margin({ right: 4, top: 8 })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#FEF7FF')
  }

  // 过滤器标签栏
  @Builder FilterBar() {
    Scroll() {
      Row() {
        ForEach(this.filterLabels, (item: string, index: number) => {
          Button(item) {
            Text(item)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(index === this.selectedFilter ? '#4A4459' : '#49454F')
          }
          .width(67)
          .height(32)
          .backgroundColor(index === this.selectedFilter ? '#E8DEF8' : '#FEF7FF')
          .border({
            width: index === this.selectedFilter ? 0 : 1,
            color: index === this.selectedFilter ? '#00000000' : '#CAC4D0',
            style: BorderStyle.Solid
          })
          .borderRadius(8)
          .margin({ right: 8 })
          .onClick(() => {
            this.selectedFilter = index;
          })
        })
      }
      .padding({ left: 8, right: 8, top: 8, bottom: 8 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .width('100%')
    .height(48)
    .backgroundColor('#FEF7FF')
  }

  // 操作按钮区域
  @Builder ActionButtons() {
    Row() {
      // 主要操作按钮
      Button({ type: ButtonType.Normal }) {
        Row() {
          Text('➕')
            .fontSize(20)
          Text('新建内容')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#6750A4')
            .margin({ left: 8 })
        }
      }
      .width(95)
      .height(40)
      .backgroundColor('#FEF7FF')
      .border({
        width: 1,
        color: '#6750A4',
        style: BorderStyle.Solid
      })
      .borderRadius(100)

      Blank()
        .layoutWeight(1)

      // 设置按钮
      Button({ type: ButtonType.Circle }) {
        Text('⚙️')
          .fontSize(24)
      }
      .width(40)
      .height(40)
      .backgroundColor('#FEF7FF')
      .border({
        width: 1,
        color: '#CAC4D0',
        style: BorderStyle.Solid
      })
      .borderRadius(100)
    }
    .width('100%')
    .height(72)
    .padding({ left: 8, right: 8 })
    .backgroundColor('#FEF7FF')
  }

  // 内容网格
  @Builder ContentGrid() {
    Grid() {
      ForEach(this.contentItems, (item: ContentItem, index: number) => {
        GridItem() {
          Column() {
            // 图片区域
            Column() {
              Text('📷')
                .fontSize(48)
            }
            .width('100%')
            .height(120)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor('#ECE6F0')
            .borderRadius(16)
            
            // 文本区域
            Column() {
              Text(item.title)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1D1B20')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              
              Text(item.time)
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor('#49454F')
                .margin({ top: 4 })
            }
            .width('100%')
            .margin({ top: 4 })
          }
          .width('100%')
          .padding(8)
          .onClick(() => {
            // 处理内容点击事件
            console.log('点击内容:', item.title);
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(8)
    .rowsGap(16)
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 16, right: 16, top: 0, bottom: 16 })
    .backgroundColor('#FEF7FF')
  }

  // 底部导航栏
  @Builder BottomNavigation() {
    Row() {
      // 首页标签
      Column() {
        Button({ type: ButtonType.Circle }) {
          Text('🏠')
            .fontSize(24)
            .fontColor(this.currentTab === 0 ? '#625B71' : '#49454F')
        }
        .width(56)
        .height(32)
        .backgroundColor(this.currentTab === 0 ? '#E8DEF8' : '#F3EDF7')
        .borderRadius(16)
        
        Text('首页')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentTab === 0 ? '#625B71' : '#49454F')
          .margin({ top: 6 })
      }
      .width('33.33%')
      .onClick(() => {
        this.currentTab = 0;
      })

      // 发现标签
      Column() {
        Button({ type: ButtonType.Circle }) {
          Text('🔍')
            .fontSize(24)
            .fontColor(this.currentTab === 1 ? '#625B71' : '#49454F')
        }
        .width(56)
        .height(32)
        .backgroundColor(this.currentTab === 1 ? '#E8DEF8' : '#F3EDF7')
        .borderRadius(16)
        
        Text('发现')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentTab === 1 ? '#625B71' : '#49454F')
          .margin({ top: 6 })
      }
      .width('33.33%')
      .onClick(() => {
        this.currentTab = 1;
      })

      // 我的标签
      Column() {
        Button({ type: ButtonType.Circle }) {
          Text('👤')
            .fontSize(24)
            .fontColor(this.currentTab === 2 ? '#625B71' : '#49454F')
        }
        .width(56)
        .height(32)
        .backgroundColor(this.currentTab === 2 ? '#E8DEF8' : '#F3EDF7')
        .borderRadius(16)
        
        Text('我的')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentTab === 2 ? '#625B71' : '#49454F')
          .margin({ top: 6 })
      }
      .width('33.33%')
      .onClick(() => {
        this.currentTab = 2;
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#F3EDF7')
  }

  // 底部指示器
  @Builder BottomIndicator() {
    Row() {
      // 使用Div代替Rectangle
      Divider()
        .width(108)
        .height(4)
        .color('#1D1B20')
        .lineCap(LineCapStyle.Round)
    }
    .width('100%')
    .height(24)
    .backgroundColor('#F3EDF7')
    .justifyContent(FlexAlign.Center)
  }
}