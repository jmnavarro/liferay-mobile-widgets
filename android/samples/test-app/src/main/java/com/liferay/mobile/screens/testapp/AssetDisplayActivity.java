package com.liferay.mobile.screens.testapp;

import android.os.Bundle;
import com.liferay.mobile.screens.asset.display.AssetDisplayListener;
import com.liferay.mobile.screens.asset.display.AssetDisplayScreenlet;
import com.liferay.mobile.screens.asset.list.AssetEntry;

/**
 * @author Sarai Díaz García
 */
public class AssetDisplayActivity extends ThemeActivity implements AssetDisplayListener {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.asset_display);

		_screenlet = ((AssetDisplayScreenlet) findViewById(R.id.asset_display_screenlet));

		_screenlet.setEntryId(getIntent().getLongExtra("entryId", 0));
		_screenlet.setListener(this);
	}

	@Override
	public void onRetrieveAssetFailure(Exception e) {
		error("Could not receive asset entry", e);
	}

	@Override
	public void onRetrieveAssetSuccess(AssetEntry assetEntry) {
		info("Asset entry received! -> " + assetEntry.getTitle());
	}

	private AssetDisplayScreenlet _screenlet;
}