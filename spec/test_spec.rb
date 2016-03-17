require './html_parser'

describe "html parser" do
  subject { HTMLParser.new }

  it "strips unnecessary html" do
    html = '<span style="color: rgb(51, 51, 51); font-family: Arial,sans-serif,sans; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none; background-color: rgb(255, 255, 255)">1 Thermal Circuit free per person/stay + 15% discount on treatments</span>'
    expected = {
      text: "1 Thermal Circuit free per person/stay + 15% discount on treatments"
    }
    expect(subject.parse(html)).to eq expected
  end

  it "converts line breaks to list items" do
    html = "<h1>Test<h1><br/>Item1</br>Item2"
    expected = {
      text: "Test",
      bullets: [
        "Item1", "Item2"
      ]
    }
    expect(subject.parse(html)).to eq expected
  end

  it "handles emphasis" do
    html = "<h1>Test<h1><br/><em>Item1</em></br>Item2"
    expected = {
      text: "Test",
      bullets: [
        { text: "Item1", em: true },
        { text: "Item2" },
      ]
    }
    expect(subject.parse(html)).to eq expected
  end
end
