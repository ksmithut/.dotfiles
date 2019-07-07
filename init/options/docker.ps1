Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv

choco install -y docker-desktop
