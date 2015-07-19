# XHAs are 'cross-over high availability' clusters, created with two Adonis servers. Each XHA has its own network
# interface, which is shared between the two servers to offer redundant services like DNS and DHCP.
class XHA < ActiveRecord::Base
  validates :master, presence: true, allow_nil: false
  validates :slave,  presence: true, allow_nil: false

  validate :xha_has_two_different_adonis, :adonis_have_no_xha_already

  belongs_to :master, class_name: 'Adonis'
  belongs_to :slave,  class_name: 'Adonis'

  has_one :network_interface, as: :networkable, inverse_of: :networkable, dependent: :destroy

  private

  def adonis_has_no_xha(adonis)
    adonis.xha.nil? || adonis.xha.id == self.id
  end

  def adonis_have_no_xha_already
    return if master.blank? || slave.blank?
    errors.add :master, I18n.t('models.xhas.validations.master_has_xha') unless adonis_has_no_xha(master)
    errors.add :slave, I18n.t('models.xhas.validations.slave_has_xha') unless adonis_has_no_xha(slave)
  end

  def xha_has_two_different_adonis
    return if (master.present? && slave.present?) && (master != slave)
    errors.add :slave, I18n.t('models.xhas.validations.different_servers')
  end
end
