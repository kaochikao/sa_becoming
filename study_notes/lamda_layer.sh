

# 應該是整個package直接被移到container的某個dir, 所以path中的python version要跟runtime version一樣
# layer compatible version也要跟function runtime一樣，不然layer加不了

mkdir -p lambda_layers/python/lib/python3.6/site-packages
pip install requests-aws4auth requests -t lambda_layers/python/lib/python3.6/site-packages/.
cd lambda_layers
zip -r layerpackage.zip *


# TODO: 加上upload layer的command
# TODO: 直接打包一個很多package的layers