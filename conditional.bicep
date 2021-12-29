param deploy bool

@allowed([
  'PRD'
  'DEV'
])
param Environment string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' existing = {
  scope: resourceGroup('defaultresourcegroup-eus')
  name: 'DefaultWorkspace-e012207b-8e1b-4f26-8a4f-ca977909d894-EUS'
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (deploy) {
  name: 'storconditionalbiceptuto'
  location: 'eastus'
  kind: 'StorageV2'
  sku: {
    name: Environment == 'PRD' ? 'Premium_LRS' : 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: Environment == 'PRD' ? true : false
  }
}

resource rDiagnosticSetting 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  name: 'DiagnosticsSta'
  scope: storageaccount
  properties: {
    workspaceId: logAnalyticsWorkspace.id

    metrics: [
      {
        category: 'Transaction'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
  }
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' existing= {
  parent: storageaccount
  name: 'default'
}

resource bDiagnosticSetting 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  name: 'DiagnosticsStablob'
  scope: blobservice
  properties: {
    workspaceId: logAnalyticsWorkspace.id

    logs: [
      {
        category: 'StorageRead'
        enabled: true
      }
      {
        category: 'StorageWrite'
        enabled: true
      }
      {
        category: 'StorageDelete'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}
output storageAccountsku string = storageaccount.sku.tier
