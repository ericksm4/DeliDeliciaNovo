# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160530173533) do

  create_table "admin_aconteces", force: true do |t|
    t.string   "titulo"
    t.text     "imagem"
    t.text     "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_areas", force: true do |t|
    t.string   "nome"
    t.string   "url"
    t.integer  "ordem"
    t.boolean  "exibe_menu"
    t.integer  "status"
    t.string   "imagem"
    t.string   "imagem_url"
    t.string   "imagem_target_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_banners", force: true do |t|
    t.string   "nome"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.integer  "status"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordem"
    t.integer  "tempo_exibicao"
    t.string   "link"
    t.string   "target_link"
    t.string   "imagem"
    t.float    "legenda_opacidade", limit: 24
    t.string   "legenda"
    t.string   "legenda_cor"
    t.string   "legenda_cor_fundo"
  end

  create_table "admin_cadastro_newsletters", force: true do |t|
    t.string   "email",             limit: 200
    t.string   "loja_mais_proxima", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_categorias", force: true do |t|
    t.string   "nome"
    t.string   "url"
    t.string   "target_url"
    t.integer  "ordem"
    t.integer  "status"
    t.string   "imagem"
    t.string   "imagem_url"
    t.string   "imagem_target_link"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "categoria_id"
  end

  create_table "admin_contatos", force: true do |t|
    t.string   "nome",          limit: 200
    t.string   "email"
    t.string   "telefone",      limit: 40
    t.string   "bairro",        limit: 200
    t.string   "cidade",        limit: 200
    t.text     "sugestoes"
    t.integer  "receber_news"
    t.datetime "data_cadastro"
  end

  create_table "admin_conteudos", force: true do |t|
    t.string   "titulo"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.integer  "detaque"
    t.integer  "status"
    t.string   "resumo"
    t.text     "conteudo"
    t.text     "imagem_destaque"
    t.text     "imagem_banner"
    t.string   "cor_titulo"
    t.integer  "categoria_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_deli_na_midia", force: true do |t|
    t.string   "titulo",      limit: 200
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_deli_na_midia_imagems", force: true do |t|
    t.text     "imagem"
    t.integer  "id_midia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_deli_sazonals", force: true do |t|
    t.string   "titulo",      limit: 200
    t.text     "conteudo"
    t.text     "imagem"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_encartes", force: true do |t|
    t.string   "nome",            limit: 200
    t.text     "imagem_destaque"
    t.integer  "status"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_imagem_encartes", force: true do |t|
    t.text     "imagem"
    t.integer  "id_encarte"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_imagem_laminas", force: true do |t|
    t.text     "imagem"
    t.integer  "id_lamina"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_laminas", force: true do |t|
    t.string   "nome",            limit: 200
    t.text     "imagem_destaque"
    t.integer  "status"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_listagem_aconteces", force: true do |t|
    t.integer  "id_acontece"
    t.string   "nome"
    t.string   "email"
    t.string   "telefone"
    t.string   "bairro"
    t.string   "cidade"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_lojas", force: true do |t|
    t.string   "nome",                  limit: 200
    t.string   "endereco",              limit: 150
    t.string   "cidade",                limit: 200
    t.string   "horario_funcionamento", limit: 50
    t.string   "telefone",              limit: 30
    t.text     "imagem"
    t.text     "url_tour"
    t.text     "url_maps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_marque_uma_visita", force: true do |t|
    t.string   "nome",        limit: 200
    t.string   "email"
    t.string   "telefone",    limit: 50
    t.string   "bairro",      limit: 150
    t.string   "cidade",      limit: 200
    t.text     "comentarios"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_novidades", force: true do |t|
    t.string   "titulo",          limit: 200
    t.text     "imagem"
    t.text     "imagem_listagem"
    t.float    "preco",           limit: 24
    t.string   "categoria",       limit: 50
    t.string   "unidade"
    t.string   "sumario"
    t.text     "conteudo"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask",             default: 2
    t.string   "nome",                   default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
