@echo off
REM Create base directories
mkdir lib\config
mkdir lib\models
mkdir lib\repositories
mkdir lib\repositories\user
mkdir lib\repositories\market
mkdir lib\repositories\market\instrument
mkdir lib\repositories\market\indice
mkdir lib\repositories\trading
mkdir lib\repositories\news
mkdir lib\services
mkdir lib\services\user
mkdir lib\services\market
mkdir lib\services\market\instrument
mkdir lib\services\market\indice
mkdir lib\services\trading
mkdir lib\services\news
mkdir lib\providers
mkdir lib\screens
mkdir lib\screens\auth
mkdir lib\screens\market
mkdir lib\screens\trading
mkdir lib\widgets
mkdir lib\widgets\common
mkdir lib\widgets\charts
mkdir lib\utils

REM Create files
echo.> lib\config\api_config.dart
echo.> lib\config\theme.dart

echo.> lib\models\user.dart
echo.> lib\models\profile.dart
echo.> lib\models\market_instrument.dart
echo.> lib\models\market_summary.dart
echo.> lib\models\market_index.dart
echo.> lib\models\market_index_summary.dart
echo.> lib\models\order.dart
echo.> lib\models\transaction.dart
echo.> lib\models\orderbook.dart
echo.> lib\models\news.dart

echo.> lib\repositories\user\auth_repo.dart
echo.> lib\repositories\user\profile_repo.dart
echo.> lib\repositories\market\instrument\instrument_repo.dart
echo.> lib\repositories\market\instrument\summary_repo.dart
echo.> lib\repositories\market\indice\index_repo.dart
echo.> lib\repositories\market\indice\summary_repo.dart
echo.> lib\repositories\trading\order_repo.dart
echo.> lib\repositories\trading\transaction_repo.dart
echo.> lib\repositories\trading\ordeer_book_repo.dart
echo.> lib\repositories\news\news_repo.dart

echo.> lib\services\user\auth_service.dart
echo.> lib\services\user\profile_service.dart
echo.> lib\services\market\instrument\instrument_service.dart
echo.> lib\services\market\instrument\summary_service.dart
echo.> lib\services\market\indice\index_service.dart
echo.> lib\services\market\indice\summary_service.dart
echo.> lib\services\trading\order_service.dart
echo.> lib\services\trading\transaction_service.dart
echo.> lib\services\trading\ordeer_book_service.dart
echo.> lib\services\news\news_service.dart
echo.> lib\services\service.dart

echo.> lib\providers\auth_provider.dart
echo.> lib\providers\market_provider.dart
echo.> lib\providers\trading_provider.dart
echo.> lib\providers\portfolio_provider.dart
echo.> lib\providers\theme_provider.dart

echo.> lib\screens\splach_screen.dart
echo.> lib\screens\auth\login_screen.dart
echo.> lib\screens\home_screen.dart
echo.> lib\screens\market\market_screen.dart
echo.> lib\screens\market\stock_details_screen.dart
echo.> lib\screens\trading\order_screen.dart
echo.> lib\screens\trading\transactions_screen.dart
echo.> lib\screens\portfolio_screen.dart
echo.> lib\screens\news_screen.dart
echo.> lib\screens\menu_screen.dart
echo.> lib\screens\profile_screen.dart

echo.> lib\widgets\common\custom_button.dart
echo.> lib\widgets\common\card.dart
echo.> lib\widgets\common\loading_widget.dart
echo.> lib\widgets\common\error_widget.dart
echo.> lib\widgets\charts\line_chart.dart
echo.> lib\widgets\charts\candlstick_chart.dart
echo.> lib\widgets\order_book_widget.dart

echo.> lib\utils\validators.dart
echo.> lib\utils\formatters.dart
echo.> lib\utils\exceptions.dart


echo ✅ All directories and files created successfully!
pause
