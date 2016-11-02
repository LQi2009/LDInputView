# LZInputView
swift编写的六位数字密码输入框,使用十分简单,只需创建后,调用一个方法即可

```
func showIn(_ view: UIView)
```
关闭调用下面的方法:
```
func dismiss()
```

在输入密码错误时,这里提供了震动提示:
```
func shake()
```

也可以直接调用重置方法:
```
func resetInput()
```
输入结果的回调,使用了代理方法,只有一个代理方法:
```
func inputView(_ view: LZInputView, didEndInput result: String)
```

因为要在返回结果时,判断是否使视图消失,为避免引起循环引用问题,这里没有使用闭包,当然使用闭包会更简洁一些!

demo中有具体是使用方法;
这里给出图片效果:<br>
![效果图](https://github.com/LQQZYY/LZInputView/blob/master/创建文件1.gif)
