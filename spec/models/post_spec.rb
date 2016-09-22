require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Validations" do

    it "requires a title" do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires title minimum lenght of 7" do
      p = Post.new
      p.title = "Hello"
      #5 characters
      p.valid?
      expect(p.errors).to have_key(:title)
    end


    it "requires a body" do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:body)
    end

    it "returns max of 100char and ..." do
    p = Post.create({title: "hellooo", body: "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"})

    outcome = p.body_snippet("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789")

    expect(outcome).to eq("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789...")
end


  end

end
