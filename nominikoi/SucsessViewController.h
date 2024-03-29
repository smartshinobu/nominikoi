//
//  SucsessViewController.h
//  nominikoi
//
//  Created by ビザンコムマック０７ on 2014/10/08.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SucsessViewController : UIViewController
//吹き出しの言葉を表示するためのラベル
@property (weak, nonatomic) IBOutlet UILabel *fukidashi;
//キャラクターの画像を表示するためのimageview
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
//音源用のプロパティ
@property (retain,nonatomic) AVAudioPlayer *voice;
@property (retain,nonatomic) AVAudioPlayer *sound;
//居酒屋のIDを格納するための変数
@property (nonatomic) NSString* shopid;
//居酒屋の名前を格納するための変数
@property (nonatomic) NSString* shopname;

@end
