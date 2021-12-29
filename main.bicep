param Param1 string = 'ResourceGroup'
param Workspace1 string = 'LogAnalytics'

var resourcegroup = resourceGroup().location

// Comentarios
resource stg 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: '${Param1}-001'
  location: resourcegroup
  sku: {
    name: 'Premium_LRS'
  }
  kind: 'StorageV2'
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: Workspace1
  location: resourcegroup
  properties: {
    sku: {
      name: 'Free'
    }
    retentionInDays: 30
    features: {
      immediatePurgeDataOn30Days: true
    }
  }
}

output output1 string = stg.id
