class Quotation < ApplicationRecord
  belongs_to :user
  belongs_to :artist, class_name: "User"
  has_many :messages, dependent: :destroy
  has_many_attached :photos

  after_create :auto_message

  SIZES = ['Small', 'Medium', 'Large']
  PLACEMENT = %w[
    Tornozelo Costas(fechamento) Costas(superior) Canela Costas(inferior) Panturrilha Peito Cotovelo
    Antebraço(interno) Antebraço(externo) Superior-Braço(interno) Superior-Braço(externo) Deltóide Braço(fechamento) Pé
    Mão(superior) Mão(palma) Quadril Joelho Pescoço Queixo Barriga Coxa(frontal) Coxa(posterior) Pulso Outro
  ].sort

  def auto_message
    message = "Olá #{artist.first_name}\n" \
              "Local da tattoo: #{placement}"
    Message.create(
      content: message, user_id:, quotation_id: id
    )
  end
end
