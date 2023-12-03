class Category < ActiveHash::Base
  self.data = [
    {id: 0, name: "---"},
    {id: 1, name: "成績"},
    {id: 2, name: "定期テスト"},
    {id: 3, name: "模試"},
  ]

  include ActiveHash::Associations
  has_many :results
end