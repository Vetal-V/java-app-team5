provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}

  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  tenant_id       = var.TENANT_ID
}

resource "azurerm_resource_group" "my-group" {
  name     = "prd-monitor-eastus-crashcourse"
  location = "eastus"
}


resource "azurerm_monitor_action_group" "main" {
  name                = "prd-monitor-act-group-eastus-crashcourse"
  resource_group_name = azurerm_resource_group.my-group.name
  short_name          = "slack-ag"

  webhook_receiver {
    name        = "slack-notification"
    service_uri = "https://crashcoursenulp2020.slack.com/archives/C011HJ7CTSN"
  }

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "somemail1"
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "somemail2"
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "somemail3"
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "somemail4"
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "somemail5"
    use_common_alert_schema = true
  }
}


resource "azurerm_monitor_metric_alert" "cpu-vm0" {
  name                = "percentage-cpu-vm0-greater75"
  resource_group_name = azurerm_resource_group.my-group.name
  scopes              = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"]
  description         = "Action will be triggered when Percentage CPU is greater than 75."
  severity            = "2"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name = "Percentage CPU"
    aggregation = "Average"
    operator = "GreaterThan"
    threshold = 75
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "cpu-vm1" {
  name                = "percentage-cpu-vm1-greater75"
  resource_group_name = azurerm_resource_group.my-group.name
  scopes              = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"]
  description         = "Action will be triggered when Percentage CPU is greater than 75."
  severity            = "2"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name = "Percentage CPU"
    aggregation = "Average"
    operator = "GreaterThan"
    threshold = 75
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "cpu-vm2" {
  name                = "percentage-cpu-vm2-greater75"
  resource_group_name = azurerm_resource_group.my-group.name
  scopes              = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"]
  description         = "Action will be triggered when Percentage CPU is greater than 75."
  severity            = "2"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name = "Percentage CPU"
    aggregation = "Average"
    operator = "GreaterThan"
    threshold = 75
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_dashboard" "my-board" {
  name                = "prd-dashboard-eastus-crashcourse"
  resource_group_name = azurerm_resource_group.my-group.name
  location            = azurerm_resource_group.my-group.location
  tags = {
    source = "terraform"
  }
  dashboard_properties = <<DASH
  {
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 5,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "settings": {
                    "content": "Virtual machine for load balancer\n---",
                    "markdownSource": 1,
                    "subtitle": "",
                    "title": ""
                  }
                }
              }
            }
          },
          "1": {
            "position": {
              "x": 5,
              "y": 0,
              "colSpan": 1,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/ClockPart",
              "settings": {
                "content": {
                  "settings": {
                    "timeFormat": "HH:mm",
                    "timezoneId": "Current",
                    "version": 1
                  }
                }
              }
            }
          },
          "2": {
            "position": {
              "x": 6,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "settings": {
                    "content": "Virtual machine for java app #1\n---",
                    "markdownSource": 1,
                    "subtitle": "",
                    "title": ""
                  }
                }
              }
            }
          },
          "3": {
            "position": {
              "x": 12,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "settings": {
                    "content": "Virtual machine for java app #2\n---",
                    "markdownSource": 1,
                    "subtitle": "",
                    "title": ""
                  }
                }
              }
            }
          },
          "4": {
            "position": {
              "x": 18,
              "y": 0,
              "colSpan": 3,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceType",
                  "value": "Microsoft.Resources/subscriptions/resourcegroups",
                  "isOptional": true
                },
                {
                  "name": "filter",
                  "isOptional": true
                },
                {
                  "name": "scope",
                  "isOptional": true
                },
                {
                  "name": "kind",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/BrowseResourceGroupPinnedPart"
            }
          },
          "5": {
            "position": {
              "x": 0,
              "y": 1,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "CPU (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "CPU (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "6": {
            "position": {
              "x": 6,
              "y": 1,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "CPU (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "CPU (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "7": {
            "position": {
              "x": 12,
              "y": 1,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "CPU (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "CPU (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "8": {
            "position": {
              "x": 18,
              "y": 4,
              "colSpan": 3,
              "rowSpan": 13
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceType",
                  "value": "Microsoft.Resources/resources",
                  "isOptional": true
                },
                {
                  "name": "filter",
                  "isOptional": true
                },
                {
                  "name": "scope",
                  "isOptional": true
                },
                {
                  "name": "kind",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/BrowseAllResourcesPinnedPart"
            }
          },
          "9": {
            "position": {
              "x": 0,
              "y": 5,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Network In Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Network (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Network In Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Network (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "10": {
            "position": {
              "x": 6,
              "y": 5,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Network In Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Network (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Network In Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Network (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "11": {
            "position": {
              "x": 12,
              "y": 5,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Network In Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Network (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Network In Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Network (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "12": {
            "position": {
              "x": 0,
              "y": 9,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Read Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Read Bytes",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Write Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Write Bytes",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk bytes (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Read Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Read Bytes",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Write Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Write Bytes",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk bytes (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "13": {
            "position": {
              "x": 6,
              "y": 9,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Read Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Read Bytes",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Write Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Write Bytes",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk bytes (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Read Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Read Bytes",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Write Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Write Bytes",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk bytes (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "14": {
            "position": {
              "x": 12,
              "y": 9,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Read Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Read Bytes",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Write Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Write Bytes",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk bytes (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Read Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Read Bytes",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Write Bytes",
                          "aggregationType": 1,
                          "metricVisualization": {
                            "displayName": "Disk Write Bytes",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk bytes (total)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "15": {
            "position": {
              "x": 0,
              "y": 13,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Read Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Read Operations/Sec",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Write Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Write Operations/Sec",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk operations/sec (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Read Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Read Operations/Sec",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm2-eastus-crashcourse"
                          },
                          "name": "Disk Write Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Write Operations/Sec",
                            "resourceDisplayName": "prd-vm2-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk operations/sec (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          },
          "16": {
            "position": {
              "x": 6,
              "y": 13,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Read Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Read Operations/Sec",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Write Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Write Operations/Sec",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk operations/sec (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Read Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Read Operations/Sec",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm0-eastus-crashcourse"
                          },
                          "name": "Disk Write Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Write Operations/Sec",
                            "resourceDisplayName": "prd-vm0-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk operations/sec (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "1440m"
                  }
                }
              }
            }
          },
          "17": {
            "position": {
              "x": 12,
              "y": 13,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Read Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Read Operations/Sec",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Write Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Write Operations/Sec",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk operations/sec (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Read Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Read Operations/Sec",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prd-vm-rg-eastus-crashcourse/providers/Microsoft.Compute/virtualMachines/prd-vm1-eastus-crashcourse"
                          },
                          "name": "Disk Write Operations/Sec",
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Disk Write Operations/Sec",
                            "resourceDisplayName": "prd-vm1-eastus-crashcourse"
                          }
                        }
                      ],
                      "title": "Disk operations/sec (average)",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "disablePinning": true
                      },
                      "openBladeOnClick": {
                        "openBlade": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "720m"
                  }
                }
              }
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "utc",
                "granularity": "auto",
                "relative": "24h"
              },
              "displayCache": {
                "name": "UTC Time",
                "value": "Past 24 hours"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0b94c",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0ba30",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0ba3c",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0ba4a",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0ba58",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bb5b",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bb67",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bb75",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bc5f",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bc6b",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bc79",
                "StartboardPart-MonitorChartPart-abdcaace-1617-4559-ac0f-5e7d36f0bc87"
              ]
            }
          }
        }
      }
    }
  }
DASH
}