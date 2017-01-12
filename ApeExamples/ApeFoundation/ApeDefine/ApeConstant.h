//
//  ApeConstant.h
//  ApeExamples
//
//  Created by Eton on 2017/1/10.
//  Copyright © 2017年 Tlsion. All rights reserved.
//

#ifndef ApeConstant_h
#define ApeConstant_h

#define AppLocaliszble @"AppLocaliszble"

#define AppSite NSLocalizedStringFromTable(@"APP_SITE",AppLocaliszble, nil)
#define APIVersion NSLocalizedStringFromTable(@"API_VERSION",AppLocaliszble, nil)
#define AppType NSLocalizedStringFromTable(@"APP_TYPE",AppLocaliszble, nil)

#define FIRST_PAGE 1
#define DEFAULT_PAGE_SIZE 10

#ifdef DEBUG
//开发环境地址
#define APPHostURL NSLocalizedStringFromTable(@"Debug_Service_URL",AppLocaliszble, nil)
#else
//开发环境地址
#define APPHostURL NSLocalizedStringFromTable(@"Release_Service_URL",AppLocaliszble, nil)

#endif

#define WebAppHostURL [NSString stringWithFormat:@"%@webapp/", APPHostURL]

#define WebAppURL(param) [NSString stringWithFormat:@"%@/%@", WebAppHostURL,param]


#endif /* ApeConstant_h */
