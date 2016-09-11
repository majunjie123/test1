//
//  AddAddressViewCell.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "AddAddressViewCell.h"
#import "AddAdressViewController.h"
#import "SelectCityViewController.h"
#import "UserAddressModel.h"

@implementation AddAddressViewCell {

    NSString *name;
    NSString *tel;
    UILabel *titleLabel;
    UILabel *carveLabel;
    UIButton *boyBtn;
    UIButton *girlBtn;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        name = [[NSString alloc] init];
        tel = [[NSString alloc] init];

        titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(15);
            make.width.equalTo(@60);
            make.height.equalTo(@30);
        }];

        _inPutTextFiled = [[UITextField alloc] init];
        _inPutTextFiled.delegate = self;
        [self addSubview:_inPutTextFiled];
        [_inPutTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(20);
            make.top.equalTo(self.mas_top).offset(15);
            make.right.equalTo(self.mas_right).offset(10);
            make.height.equalTo(@30);
        }];

        _markBtn = [[UIButton alloc] init];
        //        [markBtn setBackgroundColor:[UIColor blackColor]];
        [_inPutTextFiled addSubview:_markBtn];
        [_markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inPutTextFiled.mas_left).offset(0);
            make.top.equalTo(_inPutTextFiled.mas_top).offset(0);
            make.bottom.equalTo(_inPutTextFiled.mas_bottom).offset(0);
            make.right.equalTo(_inPutTextFiled.mas_right).offset(0);
        }];
        _markBtn.hidden = YES;

        boyBtn = [[UIButton alloc] init];
        boyBtn.tag = 1;
        [boyBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:boyBtn];
        [boyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(90);
            make.top.equalTo(self.mas_top).offset(15);
            make.height.equalTo(@30);
            make.width.equalTo(@50);
        }];
        boyBtn.hidden = YES;

        girlBtn = [[UIButton alloc] init];
        girlBtn.tag = 2;
        [girlBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:girlBtn];
        [girlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(boyBtn.mas_right).offset(30);
            make.top.equalTo(self.mas_top).offset(15);
            make.height.equalTo(@30);
            make.width.equalTo(@50);
        }];
        girlBtn.hidden = YES;

        carveLabel = [[UILabel alloc] init];
        [self addSubview:carveLabel];
        carveLabel.backgroundColor = [UIColor lightGrayColor];
        [carveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-2);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@1);

        }];
    }
    return self;
}

//- (void)setContentWithObject:(NSArray *)object AtIndexPath:(NSIndexPath *)indexPath {
//
//    _inPutTextFiled.tag = indexPath.row;
//    if (indexPath.row > 0) {
//        titleLabel.text = object[indexPath.row - 1][0];
//        _inPutTextFiled.placeholder = object[indexPath.row - 1][1];
//        [_inPutTextFiled setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//
//        if (indexPath.row == 1) {
//            titleLabel.hidden = YES;
//            _inPutTextFiled.hidden = YES;
//            boyBtn.hidden = NO;
//            girlBtn.hidden = NO;
//
//            [boyBtn setTitle:@"先生" forState:UIControlStateNormal];
//            [boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [girlBtn setTitle:@"女士" forState:UIControlStateNormal];
//            [girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//
//            [boyBtn setBackgroundColor:[UIColor orangeColor]];
//            [girlBtn setBackgroundColor:[UIColor clearColor]];
//            _userAddressModel.u_sex = @"男";
//            //            [_infoDict setObject:@"男" forKey:@"sex"];
//
//        } else {
//            titleLabel.hidden = NO;
//            _inPutTextFiled.hidden = NO;
//            boyBtn.hidden = YES;
//            girlBtn.hidden = YES;
//        }
//        NSLog(@"%@", titleLabel.text);
//        if (indexPath.row == 3) {
//            _markBtn.hidden = NO;
//
//        } else {
//            _markBtn.hidden = YES;
//        }
//    } else {
//
//        _inPutTextFiled.placeholder = object[indexPath.row][1];
//        [_inPutTextFiled setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//        titleLabel.text = object[indexPath.row][0];
//    }
//    //[infoDict setValue:inPutTextFiled.text forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //NSLog(@"%d",textField.tag);
    if (_model) {
        switch (textField.tag) {
        case 0:
            _model.u_name = textField.text;
            NSLog(@"%@", textField.text);
            break;
        case 2:
            _model.u_tel = textField.text;
            break;
        case 4:
            NSLog(@"%@", name);
            _model.u_homeAddress = textField.text;
            break;

        default:
            break;
        }
    } else {
        switch (textField.tag) {
        case 0:
            _userAddressModel.u_name = textField.text;
            NSLog(@"%@", textField.text);
            break;
        case 2:
            _userAddressModel.u_tel = textField.text;
            break;
        case 4:
            NSLog(@"%@", name);
            _userAddressModel.u_homeAddress = textField.text;
            break;

        default:
            break;
        }
    }
}
- (void)selectSex:(UIButton *)send {
    if (send.tag == 1) {
        //男
        [boyBtn setBackgroundColor:[UIColor orangeColor]];
        [girlBtn setBackgroundColor:[UIColor clearColor]];
        _userAddressModel.u_sex = @"先生";
        _model.u_sex = @"先生";
    } else {
        //女
        [girlBtn setBackgroundColor:[UIColor orangeColor]];
        [boyBtn setBackgroundColor:[UIColor clearColor]];
        _userAddressModel.u_sex = @"女士";
        _model.u_sex = @"女士";
    }
}
- (void)setContentWithObject:(NSArray *)object AtIndexPath:(NSIndexPath *)indexPath {
    _inPutTextFiled.tag = indexPath.row;
    if (indexPath.row > 0) {
        titleLabel.text = object[indexPath.row - 1][0];
        _inPutTextFiled.placeholder = object[indexPath.row - 1][1];
        [_inPutTextFiled setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

        if (indexPath.row == 1) {
            titleLabel.hidden = YES;
            _inPutTextFiled.hidden = YES;
            boyBtn.hidden = NO;
            girlBtn.hidden = NO;

            [boyBtn setTitle:@"先生" forState:UIControlStateNormal];
            [boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [girlBtn setTitle:@"女士" forState:UIControlStateNormal];
            [girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (_model == nil) {
                [boyBtn setBackgroundColor:[UIColor orangeColor]];
                [girlBtn setBackgroundColor:[UIColor clearColor]];
                _userAddressModel.u_sex = @"先生";
                _model.u_sex = @"先生";
            } else {
                if ([_model.u_sex isEqualToString:@"先生"]) {
                    [boyBtn setBackgroundColor:[UIColor orangeColor]];
                    [girlBtn setBackgroundColor:[UIColor clearColor]];
                    _userAddressModel.u_sex = @"先生";
                    _model.u_sex = @"先生";
                } else {
                    [girlBtn setBackgroundColor:[UIColor orangeColor]];
                    [boyBtn setBackgroundColor:[UIColor clearColor]];
                    _userAddressModel.u_sex = @"女士";
                    _model.u_sex = @"女士";
                }
            }

        } else {
            titleLabel.hidden = NO;
            _inPutTextFiled.hidden = NO;
            boyBtn.hidden = YES;
            girlBtn.hidden = YES;
        }
        NSLog(@"%@", titleLabel.text);
        if (indexPath.row == 3) {
            _markBtn.hidden = NO;

        } else {
            _markBtn.hidden = YES;
        }
    } else {

        _inPutTextFiled.placeholder = object[indexPath.row][1];
        [_inPutTextFiled setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        titleLabel.text = object[indexPath.row][0];
    }
    if (!(_model == nil)) {
        if (indexPath.row == 0) {
            _inPutTextFiled.text = _model.u_name;
            //_userAddressModel.u_name = _inPutTextFiled.text;
        }
        if (indexPath.row == 1) {
            if ([_model.u_sex isEqual:@"先生"]) {
                //男
                [boyBtn setBackgroundColor:[UIColor orangeColor]];
                [girlBtn setBackgroundColor:[UIColor clearColor]];
                _userAddressModel.u_sex = @"先生";
                _model.u_sex = @"先生";
            } else {
                //女
                [girlBtn setBackgroundColor:[UIColor orangeColor]];
                [boyBtn setBackgroundColor:[UIColor clearColor]];
                _userAddressModel.u_sex = @"女士";
                _model.u_sex = @"女士";
            }
        }
        if (indexPath.row == 2) {
            _inPutTextFiled.text = _model.u_tel;
        
        }
        if (indexPath.row == 3) {
            _inPutTextFiled.text = _model.u_city;
           
        }
        if (indexPath.row == 4) {
            _inPutTextFiled.text = _model.u_homeAddress;
           
        }
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
