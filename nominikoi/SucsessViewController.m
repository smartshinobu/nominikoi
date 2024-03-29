//
//  SucsessViewController.m
//  nominikoi
//
//  Created by ビザンコムマック０７ on 2014/10/08.
//  Copyright (c) 2014年 mycompany. All rights reserved.
// 成功画面を管理するクラス

#import "SucsessViewController.h"
#import "ChoiceViewController.h"
#import "Webreturn.h"
#import "AppDelegate.h"



@interface SucsessViewController (){
    //サーバーのURLの文字列を格納するための変数
    NSString *serverurl;
}


@end

@implementation SucsessViewController

- (void)viewDidLoad {
    AppDelegate* delegate = [[UIApplication sharedApplication]delegate];
    NSLog(@"%@",delegate.accoutid);
    //履歴をデータベースに保存するphpのURLの文字列を格納
    serverurl = @"http://smartshinobu.miraiserver.com/nominikoi/shopadd.php?id=(id)&shopid=(shopid)&shopname=(shopname)";
    //最初の吹き出し言葉を設定
    self.fukidashi.text = @"お〜お疲れ\n先に飲んじゃってごめん。";
    //imageviewのアスペクト比を維持
    self.imageview.contentMode = UIViewContentModeScaleAspectFit;
    //appdelegateのインスタンスのプロパティaccountidの文字列の長さが0より大きいか
    //ログイン状態を維持しているか
    if ([delegate.accoutid length] > 0) {
        NSLog(@"%@",delegate.accoutid);
        NSLog(@"%@",self.shopid);
        NSLog(@"%@",self.shopname);
        //serverurlの中に文字列(id)をログインしているIDの文字列に変更
        serverurl = [serverurl stringByReplacingOccurrencesOfString:@"(id)" withString:delegate.accoutid];
        //serverurlの中に文字列(id)を居酒屋IDの文字列に変更
        serverurl = [serverurl stringByReplacingOccurrencesOfString:@"(shopid)" withString:self.shopid];
        //日本語の部分をエンコード
        NSString *encodeshop = [self.shopname stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
        //serverurlの中に文字列(shopname)を居酒屋名前の文字列に変更
        serverurl = [serverurl stringByReplacingOccurrencesOfString:@"(shopname)" withString:encodeshop];
        //サーバーのデータを格納
        NSData *data = [Webreturn ServerData:serverurl];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"dic = %@",dic);
    }
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//1回目の吹き出しの言葉を変えるメソッド
-(void)firstfukidashi{
    self.fukidashi.text = @"時間内についたから\nいいことを教えて上げる";
    //3秒後にメソッドsecondfukidashiを実行
    [self performSelector:@selector(secondfukidashi) withObject:nil afterDelay:3];

}

//2回目の吹き出しの言葉を変えるメソッド
-(void)secondfukidashi{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sucsess" ofType:@"plist"];
    //良い言葉を格納するための配列
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //arrayの中からランダムに選ばれた言葉を表示
    self.fukidashi.text = [array objectAtIndex:arc4random()%[array count]];
    //3秒後にメソッドkanpaibeforeを実行
    [self performSelector:@selector(kanpaibefore) withObject:nil afterDelay:3];

}

//乾杯の言葉を表示する前に実行するメソッド
-(void)kanpaibefore{
    //fukidashiのフォントサイズを35に変更
    self.fukidashi.font = [UIFont systemFontOfSize:35];
    self.fukidashi.text = @"じゃ";
    //2秒後にメソッドkanpaiを実行
    [self performSelector:@selector(kanpai) withObject:nil afterDelay:2];
}

//乾杯の言葉を表示するメソッド
-(void)kanpai{
    self.fukidashi.text = @"乾杯〜";
    //アニメーションに使う画像を格納するための配列
    NSMutableArray *imagelist = [NSMutableArray array];
    //配列の要素を追加するための処理
    for (int i = 3; i <= 4; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"joushibeel%d.png",i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imagelist addObject:img];
    }
    //アニメーションに使う画像の配列を設定
    self.imageview.animationImages = imagelist;
    //アニメーションの間隔を0.5秒に設定
    self.imageview.animationDuration = 0.5;
    //アニメーションのリピート回数を1回に設定
    self.imageview.animationRepeatCount = 1;
    //アニメーションを開始
    [self.imageview startAnimating];
    //音声ファイルの場所を示す文字列を格納
    NSString *path = [[NSBundle mainBundle]pathForResource:@"kanpai" ofType:@"mp3"];
    //音声ファイルの場所をURL形式に変換
    NSURL *url = [NSURL fileURLWithPath:path];
    //urlを元にインスタンスを生成
    self.voice = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    //音声ファイルの場所を示す文字列を格納
    path = [[NSBundle mainBundle]pathForResource:@"glass" ofType:@"mp3"];
    //音声ファイルの場所をURL形式に変換
    url = [NSURL fileURLWithPath:path];
    //urlを元にインスタンスを生成
    self.sound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    //音声ファイルを再生
    [self.voice play];
    [self.sound play];

    //3秒後にメソッドbackを実行
    [self performSelector:@selector(back) withObject:nil afterDelay:3];
}

//選択画面に戻るメソッド
-(void)back{
    
    //名前がsucsessbacksegueであるセグエを実行
    [self performSegueWithIdentifier:@"sucsessbacksegue" sender:self];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    //3秒後にメソッドfirstfukidashiを実行
    [self performSelector:@selector(firstfukidashi) withObject:nil afterDelay:3];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
