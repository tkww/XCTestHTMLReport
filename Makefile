#!/usr/bin/xcrun make -f

PACKAGE_NAME="XCTestHTMLReport"
PRODUCT_PATH=build/release/xchtmlreport
PACKAGE_PATH=package/$(PACKAGE_NAME).zip

include .env

.PHONY: all build clean release xcodeproj

all: build

clean:
	rm -rf build package
	rm -rf XCTestHTMLReport.xcodeproj

build:
	swift build --disable-sandbox -c release --build-path build

package: build
	mkdir -p package
	zip -r $(PACKAGE_PATH) $(PRODUCT_PATH)

release: package
	$(eval LAST_VERSION=$(shell (git tag -l | grep -Eo '[0-9\.]+' | tail -1)))
	$(eval VERSION=$(shell read -p 'New Version (previously $(LAST_VERSION)): ' VER; echo $$VER))
	@echo "Bumping version from $(LAST_VERSION) to $(VERSION)"
	@git tag $(VERSION)
	@git push origin $(VERSION)
	@github-release release \
		--security-token $(GITHUB_TOKEN) \
    --user tkww \
    --repo $(PACKAGE_NAME) \
    --tag $(VERSION) \
    --name "$(PACKAGE_NAME) Release $(VERSION)" && \
  github-release upload \
  	--security-token $(GITHUB_TOKEN) \
    --user tkww \
    --repo $(PACKAGE_NAME) \
    --tag $(VERSION) \
    --name "$(PACKAGE_NAME).zip" \
    --file $(PACKAGE_PATH)	

xcodeproj:
	@swift package generate-xcodeproj