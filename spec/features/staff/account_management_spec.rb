require 'rails_helper'

feature '職員による自身のアカウント管理' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
    click_link 'アカウント'
    click_link '編集'
  end

  scenario '職員がメールアドレスを変更する' do
    fill_in 'メールアドレス', with: 'test@example.com'
    click_button '確認画面に進む'
    click_button '更新'
    
    staff_member.reload
    expect(staff_member.email).to eq('test@example.com')
  end

  scenario '顧客が生年月日と自宅の郵便番号に無効な値を入力する' do
    fill_in 'メールアドレス', with: 'test@@example.com'
    click_button '確認画面に進む'

    expect(page).to have_css('header span.alert')
  end
end