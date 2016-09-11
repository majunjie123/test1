//
//  adressViewCell.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/13.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "adressViewCell.h"
#import "UserAddressModel.h"
@implementation adressViewCell {
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UILabel *adressLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UILabel *carveLabel = [[UILabel alloc] init];
        [self addSubview:carveLabel];
        carveLabel.backgroundColor = [UIColor lightGrayColor];
        [carveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@0.5);
        }];

        UILabel *carveLabel2 = [[UILabel alloc] init];
        [self addSubview:carveLabel2];
        carveLabel2.backgroundColor = [UIColor lightGrayColor];
        [carveLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.right.equalTo(self.mas_right).offset(-80);
            make.width.equalTo(@0.5);
        }];

        nameLabel = [[UILabel alloc] init];
        nameLabel.font=[UIFont systemFontOfSize:13.0];
        [self addSubview:nameLabel];
        nameLabel.text = @"11111111111";
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(20);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        phoneLabel = [[UILabel alloc] init];
        phoneLabel.font=[UIFont systemFontOfSize:13.0];
        phoneLabel.text = @"11111111";
        [self addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(20);
            make.top.equalTo(nameLabel.mas_top).offset(0);
            make.right.equalTo(carveLabel2.mas_left).offset(-10);
            make.height.equalTo(@20);
        }];

        adressLabel = [[UILabel alloc] init];
        adressLabel.font=[UIFont systemFontOfSize:13.0];
        adressLabel.text = @"1111";
        [self addSubview:adressLabel];
        [adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_left).offset(0);
            make.top.equalTo(nameLabel.mas_top).offset(30);
            make.right.equalTo(carveLabel2.mas_left).offset(-10);
            make.height.equalTo(@20);
        }];

        _editButton = [[UIButton alloc] init];
        [self addSubview:_editButton];
        [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(carveLabel2.mas_right).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);

        }];

        UIImageView *editImageBG = [[UIImageView alloc] init];
        [editImageBG setImage:[UIImage imageNamed:@"v2_address_edit_normal"]];
        [_editButton addSubview:editImageBG];
        [editImageBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_editButton.mas_left).offset(15);
            make.right.equalTo(_editButton.mas_right).offset(-15);
            make.top.equalTo(_editButton.mas_top).offset(15);
            make.bottom.equalTo(_editButton.mas_bottom).offset(-15);

        }];
    }
    return self;
}

- (void)setContentWithObject:(NSArray *)object AtIndexPath:(NSIndexPath *)indexPath {
    UserAddressModel *user=object[indexPath.row];
    phoneLabel.text=user.u_tel;
    nameLabel.text=user.u_name;
    adressLabel.text=[NSString stringWithFormat:@"%@  %@",user.u_city,user.u_homeAddress];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
