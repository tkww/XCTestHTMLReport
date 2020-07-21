#!/usr/bin/xcrun make -f

PRODUCT_PATH=.build/release/xchtmlreport
PACKAGE_PATH=package/XCTestHTMLReport.zip

include .env

.PHONY: all build clean release xcodeproj

all: build

clean:
	rm -rf build package
	rm -rf XCTestHTMLReport.xcodeproj
	rm */Info.plist

build:
	swift build --disable-sandbox -c release

package: build
	mkdir -p package
	cd ./$(PRODUCT_PATH) && zip -r ../../$(PACKAGE_PATH) ./*

release: package
	$(eval LAST_VERSION=$(shell (git tag -l | grep -Eo '[0-9\.]+' | tail -2 | head -1)))
	$(eval VERSION=$(shell read -p 'New Version (previously $(LAST_VERSION)): ' VER; echo $$VER))
	@echo "Bumping version from $(LAST_VERSION) to $(VERSION)"
	@git tag $(VERSION)
	@git push origin $(VERSION)
	@github-release release \
		--security-token $(GITHUB_TOKEN) \
    --user tkww \
    --repo TKCore-iOS \
    --tag $(VERSION) \
    --name "XCTestHTMLReport Release $(VERSION)" && \
  github-release upload \
  	--security-token $(GITHUB_TOKEN) \
    --user tkww \
    --repo XCTestHTMLReport \
    --tag $(VERSION) \
    --name "XCTestHTMLReport-$(VERSION).zip" \
    --file ./$(PACKAGE_PATH)	

xcodeproj:
	@swift package generate-xcodeproj