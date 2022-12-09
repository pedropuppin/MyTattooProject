class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  include PgSearch::Model

  def to_s
    name.capitalize
  end

  pg_search_scope :search_by_name,
  against: [ :name ],
  using: {
    tsearch: { prefix: true }
  }

  TAG = ['Black & Gray', 'Blackwork', 'Chicano', 'Dotwork', 'Fineline', 'Geometric', 'Hand-Poked', 'Dark Art', 'Japanese (Irezumi)', 'Lettering',
    'Neo Traditional', 'New School', 'Ornamental', 'Realism', 'Illustrative', 'Old School (Traditional)', 'Trash Polka Style',
    'Tribal', 'Watercolor', 'Surrealism', 'Cosmetic', 'Ignorant']



  def self.jujubinha(key)
    hash = {
      'black & gray' => "O estilo Black and Grey ou Preto e Cinza é um dos estilos mais comuns no Brasil e é característico pela técnica que utiliza escala de tons pretos e cinzas para compor a tatuagem. A principal característica desse estilo é que as tatuagens parecem fotos em preto e branco impressas sobre a pele. Para isso, quase ou nenhuma pigmentação branca é utilizada. A pele que dará a sensação de pigmentação branca.",
      'blackwork' => "O próprio nome já diz: as tatuagens blackwork são aquelas feitas com a tinta preta. Ou seja, nada de cores! E quem ama tattoos mais sóbrias com certeza tem uma afinidade maior por esse estilo. O mais legal é que, mesmo sem uma paleta de cores, é possível fazer desenhos incríveis e super complexos.",
      'chicano' => "O estilo se baseia em desenhos que retratam a vida das pessoas que vivem nesse meio, um estilo meio gangster. Em muitos desenhos ele se assemelha com o realismo, mas com suas próprias características e vertentes. Como não poderia deixar de ser, o Chicano leva sua verdade para a pele do tatuado demonstrando um individualismo característico. O estilo tem como objetivo, retratar na pele a história do indivíduo. Família e espiritualidade são os temas mais utilizados na tatuagem chicana. Na maioria das vezes é retratado com preto e cinza, uma vez que o tom de pele favorece o black & gray e é sua composição original, destacando as sombras por trás do desenho. Suas fontes também são características tendo fortes influências da rua e de pichações e é muito comum você ver pessoas por aí com esse tipo de fonte tatuado.",
      'dotwork' => "Estilo de tatuagem que consiste em fazer ponto por ponto uma tatuagem inteira, ou usar este estilo para sombrear algumas partes de desenhos. Ele já é usado em quase todos os outros estilos de tatuagem pra incrementar, mas o que deixa a galera mais surpresa e encantada é quando o estilo começa e termina em pontilhismo. Alguns artistas tem sua própria maneira de fazer, uns usam as máquinas de tatuar convencionais, outros usam o tebori, que é aquele estilo de tatuagem oriental muito antiga de se tatuar apenas com uma vara de bambu, e usar as mãos como máquina. Outros já usam as agulhas modernas para fazer, só que sem usar as máquinas e fazer toda a tatuagem no \"muque\" mesmo.",
      'fineline' => "fineline eh linha daora",
      'geometric' => "geometrico eh euclides",
      'hand-poked' => "hand poked eh cutucao do feicebuc",
      'dark art' => "dark art eh trevoso",
      'japanese (irezumi)' => "ching chongh hanji",
      'lettering' => "letras",
      'neo traditional' => "tradwave",
      'new school' => "novaera petista safada",
      'ornamental' => "cornamental",
      'realism' => "real",
      'illustrative' => "ilustra issaqui ó",
      'old school (traditional)' => "velhaera petista safada",
      'trash polka style' => "lixo polones",
      'tribal' => "tribos",
      'watercolor' => "azul, portanto (ou transparente)",
      'surrealism' => "salvador dali",
      'cosmetic' => "farmacia",
      'ignorant' => "eu"
    }

    return hash[key]
  end
end
