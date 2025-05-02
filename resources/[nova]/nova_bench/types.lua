---@class ItemProps
---@field item string Item Name
---@field value number Item Price
---@field amount number Item Amount
---@field owner number Item Owner User_Id
---@field id number Item Database Id

---@class PendingItem
---@field item string Item Name
---@field amount number Item Amount
---@field value number Item Price
---@field owner number Item Owner User_Id

---@alias MachineName string
---@alias PlayerIds table<number, MachineName>

---@class Bench
---@field infos table<MachineName, ItemProps[]>
---@field playersActives PlayerIds
---@field logs table<MachineName, string[]>
---@field GetLogs fun(self: Bench, MachineName: string): string[]
---@field PayUser fun(self: Bench, user_id: number, price: number): boolean
---@field EditItem fun(self: Bench, MachineName: string, idx: number, new_price: number): boolean, string?
---@field AddItem fun(self: Bench, MachineName: string, item: PendingItem, user_id: number): boolean, string?
---@field RemoveItem fun(self: Bench, MachineName: string, idx: number, amount: number): boolean, string?
---@field GetItems fun(self: Bench, MachineName: string): ItemProps[]
---@field GetItem fun(self: Bench, MachineName: string, idx: number): ItemProps | false, string?
---@field SyncBench fun(self: Bench, MachineName: string)


---@class BenchResponse
---@field method "STORE" | "EDIT_BENCH"
---@field bench ItemProps[]
---@field weight number?
---@field maxWeight number?
---@field inventory? table<string, any>
---@field logs? string[]