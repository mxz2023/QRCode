/**
 * Copyright (c) 2023-2025 Mxz Co., Ltd.
 *
 * @file ContentPage.ets
 * @project QRCode
 * @author vincent_gemini
 * @crateTime 2025-10-30
 * @desc 二维码管理页面 - 基于Figma设计实现
 */

import { ColorConstants, FontSizeConstants, AppConstants } from "../common/CommonDefine";

@Component
export struct ContentPage {
  @State selectedTab: number = 1
  @State showCreatePanel: boolean = false
  
  // 示例二维码数据
  private qrCodeList: Array<QRCodeItem> = [
    { id: 1, name: "个人名片", description: "包含联系信息的二维码", category: 1 },
    { id: 2, name: "WiFi连接", description: "快速连接WiFi网络", category: 1 },
    { id: 3, name: "网址链接", description: "跳转到指定网页", category: 2 },
    { id: 4, name: "文本信息", description: "存储重要文本内容", category: 2 },
    { id: 5, name: "联系方式", description: "分享电话号码", category: 1 },
    { id: 6, name: "地理位置", description: "分享位置信息", category: 3 },
    { id: 7, name: "邮箱地址", description: "快速发送邮件", category: 3 },
    { id: 8, name: "社交媒体", description: "关注社交媒体账号", category: 1 }
  ]
  
  // 创建二维码选项
  private createOptions: Array<CreateOption> = [
    { id: 1, name: "文本二维码", description: "创建包含文本内容的二维码" },
    { id: 2, name: "网址二维码", description: "创建跳转到网页的二维码" },
    { id: 3, name: "名片二维码", description: "创建个人名片二维码" },
    { id: 4, name: "WiFi二维码", description: "创建WiFi连接二维码" },
    { id: 5, name: "位置二维码", description: "创建地理位置二维码" }
  ]

  private handleTabSelect(index: number): void {
    this.selectedTab = index
  }

  private toggleCreatePanel(): void {
    this.showCreatePanel = !this.showCreatePanel
  }

  private getFilteredQRCodeList(): Array<QRCodeItem> {
    if (this.selectedTab === 0) {
      return this.qrCodeList // 全部
    }
    return this.qrCodeList.filter(item => item.category === this.selectedTab)
  }

  build() {
    Stack() {
      // 主内容区域
      Column() {
        // 标签栏区域
        this.buildTabBar()

        // 二维码网格区域
        this.buildQRCodeGrid()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ColorConstants.View_Background_Color)

      // 创建二维码浮层
      if (this.showCreatePanel) {
        this.buildCreatePanel()
      }

      // 悬浮创建按钮
      this.buildFloatingButton()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildTabBar() {
    Column() {
      Scroll() {
        Row({ space: 8 }) {
          // 全部标签
          Button() {
            Text('全部')
              .fontSize(FontSizeConstants.Small)
              .fontColor(this.selectedTab === 0 ? ColorConstants.Text_333 : ColorConstants.Text_666)
              .fontWeight(FontWeight.Medium)
          }
          .width(67)
          .height(32)
          .backgroundColor(this.selectedTab === 0 ? ColorConstants.Primary_Color : ColorConstants.White)
          .borderRadius(8)
          .border({
            width: this.selectedTab === 0 ? 0 : 1,
            color: this.selectedTab === 0 ? Color.Transparent : ColorConstants.Line_Color
          })
          .onClick(() => {
            this.handleTabSelect(0)
          })

          // 分类标签
          ForEach([1, 2, 3], (index: number) => {
            Button() {
              Row() {
                if (index === 1) {
                  Image($rawfile('5.svg'))
                    .width(16)
                    .height(16)
                    .margin({ right: 8 })
                }
                
                Text(this.getCategoryName(index))
                  .fontSize(FontSizeConstants.Small)
                  .fontColor(this.selectedTab === index ? ColorConstants.Text_333 : ColorConstants.Text_666)
                  .fontWeight(FontWeight.Medium)
              }
              .justifyContent(FlexAlign.Center)
            }
            .width(index === 1 ? 85 : 67)
            .height(32)
            .backgroundColor(this.selectedTab === index ? ColorConstants.Primary_Color : ColorConstants.White)
            .borderRadius(8)
            .border({
              width: this.selectedTab === index ? 0 : 1,
              color: this.selectedTab === index ? Color.Transparent : ColorConstants.Line_Color
            })
            .onClick(() => {
              this.handleTabSelect(index)
            })
          })
        }
        .padding({ left: 8, right: 8, top: 8, bottom: 8 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
    }
    .width('100%')
    .height(48)
    .backgroundColor(ColorConstants.White)
  }

  @Builder
  buildQRCodeGrid() {
    Column() {
      // 网格标题
      Text('我的二维码')
        .fontSize(FontSizeConstants.LargeTitle)
        .fontColor(ColorConstants.Text_333)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 24, bottom: 16, left: 16 })

      // 二维码网格
      Grid() {
        ForEach(this.getFilteredQRCodeList(), (item: QRCodeItem) => {
          GridItem() {
            this.buildQRCodeCard(item)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .padding({ left: 16, right: 16, bottom: 80 })
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildQRCodeCard(item: QRCodeItem) {
    Column() {
      // 二维码图标区域
      Column() {
        // 这里可以放置二维码图标或预览图
        Text('QR')
          .fontSize(FontSizeConstants.NavTitle)
          .fontColor(ColorConstants.Primary_Color)
          .fontWeight(FontWeight.Bold)
      }
      .width(60)
      .height(60)
      .backgroundColor(ColorConstants.White)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // 二维码信息
      Text(item.name)
        .fontSize(FontSizeConstants.Small)
        .fontColor(ColorConstants.Text_333)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 8 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(item.description)
        .fontSize(FontSizeConstants.Small)
        .fontColor(ColorConstants.Text_666)
        .margin({ top: 4 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(ColorConstants.White)
    .borderRadius(12)
    .shadow({
      radius: 8,
      color: ColorConstants.View_Mask,
      offsetX: 2,
      offsetY: 2
    })
  }

  @Builder
  buildCreatePanel() {
    Column() {
      // 浮层标题
      Row() {
        Text('创建二维码')
          .fontSize(FontSizeConstants.Medium)
          .fontColor(ColorConstants.Text_333)
          .fontWeight(FontWeight.Bold)
        
        Blank()
        
        Button() {
          Text('关闭')
            .fontSize(FontSizeConstants.Small)
            .fontColor(ColorConstants.Primary_Color)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.toggleCreatePanel()
        })
      }
      .width('100%')
      .padding({ top: 16, left: 16, right: 16 })

      // 创建选项列表
      List({ space: 12 }) {
        ForEach(this.createOptions, (option: CreateOption) => {
          ListItem() {
            this.buildCreateOption(option)
          }
        })
      }
      .padding({ top: 16, left: 16, right: 16, bottom: 16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height(300)
    .backgroundColor(ColorConstants.White)
    .borderRadius(16)
    .shadow({
      radius: 16,
      color: ColorConstants.View_Mask,
      offsetX: 0,
      offsetY: -4
    })
    .position({
      x: 0,
      y: this.showCreatePanel ? '100% - 300' : '100%'
    })
    .animation({
      duration: 300,
      curve: Curve.EaseOut
    })
  }

  @Builder
  buildCreateOption(option: CreateOption) {
    Row() {
      Column({ space: 4 }) {
        Text(option.name)
          .fontSize(FontSizeConstants.Medium)
          .fontColor(ColorConstants.Text_333)
          .fontWeight(FontWeight.Medium)
        
        Text(option.description)
          .fontSize(FontSizeConstants.Small)
          .fontColor(ColorConstants.Text_666)
      }
      .layoutWeight(1)
      
      Image($rawfile('5.svg'))
        .width(20)
        .height(20)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ColorConstants.View_Background_Color)
    .borderRadius(8)
    .onClick(() => {
      // 处理创建二维码逻辑
      console.log(`创建: ${option.name}`)
    })
  }

  private getCategoryName(category: number): string {
    switch (category) {
      case 1: return '常用'
      case 2: return '链接'
      case 3: return '其他'
      default: return '标签'
    }
  }

  @Builder
  buildFloatingButton() {
    Button() {
      Image($rawfile('5.svg'))
        .width(24)
        .height(24)
    }
    .width(56)
    .height(56)
    .backgroundColor(ColorConstants.Primary_Color)
    .borderRadius(28)
    .shadow({
      radius: 8,
      color: ColorConstants.View_Mask,
      offsetX: 0,
      offsetY: 4
    })
    .position({
      x: '85%',
      y: '85%'
    })
    .onClick(() => {
      this.toggleCreatePanel()
    })
  }
}

interface QRCodeItem {
  id: number
  name: string
  description: string
  category: number
}

interface CreateOption {
  id: number
  name: string
  description: string
}