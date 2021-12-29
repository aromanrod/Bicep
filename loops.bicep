param stgCount int = 2
param Stgdeps array = [
  'mercadeo'
  'ventas'
]
param Stgdeps1 array = [
  {
    'dept': 'compras'
    'sku': 'Standard_LRS'
  }
  {
    'dept': 'finanzas'
    'sku': 'Premium_LRS'
  }
]
//Usando Int para indices
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(0, stgCount): {
  name: 'stg${i}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

resource storageaccount2 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(2, stgCount): {
  name: 'stg${i}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

// Arreglo (array)
resource storageaccount3 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in Stgdeps: {
  name: 'stg${i}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

resource storageaccount4 'Microsoft.Storage/storageAccounts@2021-02-01' = [for storage in Stgdeps1: {
  name: 'stg${storage.dept}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: storage.sku
  }
}]
//output con INT en Arrays
output StorageNames1 array = [for i in range(0, stgCount): {
  name: storageaccount[i].name
  id: storageaccount[i].id
}]

output StorageNames2 array = [for i in range(0, stgCount): {
  name: storageaccount2[i].name
  id: storageaccount2[i].id
}]
//Output con String en arrays
output StorageNames3 array = [for (name,i) in Stgdeps: {
  name: storageaccount3[i].name
  id: storageaccount3[i].id
}]

output StorageNames4 array = [for (name, i) in Stgdeps1: {
  name: storageaccount4[i].name
  id: storageaccount4[i].id
}]
