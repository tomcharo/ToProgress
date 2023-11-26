class Grade < ActiveHash::Base
  self.data = [
    {id: 0, name: "---"},
    {id: 1, name: "講師"},
    {id: 2, name: "中１"},
    {id: 3, name: "中２"},
    {id: 4, name: "中３"},
    {id: 5, name: "高１"},
    {id: 6, name: "高２"},
    {id: 7, name: "高３"}
  ]

  include ActiveHash::Associations
  has_many :users
end