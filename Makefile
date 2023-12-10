clean:
	dart run build_runner clean
	flutter clean
	
dev:
	flutter run --debug

start: 
	flutter run --release

abi:
	flutter build appbundle --split-per-abi

icon: 
	flutter pub run flutter_launcher_icons

generate:
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner clean
	dart run build_runner watch --delete-conflicting-outputs

# reset:
# 	flutter clean
#     flutter pub get
#     dart run build_runner clean
#     dart run build_runner build --delete-conflicting-outputs