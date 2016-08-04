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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pvcrequests", id: :uuid, default: -> { "uuid_in((md5((random())::text))::cstring)" }, force: :cascade do |t|
    t.datetime "creationtimestamp",             null: false
    t.string   "name",              limit: 100, null: false
    t.string   "kind",              limit: 100, null: false
    t.string   "namespace",         limit: 100, null: false
    t.string   "selflink",          limit: 100, null: false
    t.string   "accessmode",        limit: 50
    t.string   "storage",           limit: 10,  null: false
    t.string   "phase",             limit: 10,  null: false
    t.string   "apiversion",        limit: 20,  null: false
    t.uuid     "pvcuid",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["pvcuid"], name: "pvcuid_request_constraint", unique: true, using: :btree
  end

  create_table "pvprovisions", id: :uuid, default: -> { "uuid_in((md5((random())::text))::cstring)" }, force: :cascade do |t|
    t.datetime "pvcreationtimestamp",             default: -> { "now()" }
    t.string   "name",                limit: 100,                                                    null: false
    t.string   "pvcname",             limit: 100,                                                    null: false
    t.string   "pvcnamespace",        limit: 100
    t.uuid     "pvcuid",                                                                             null: false
    t.string   "kind",                limit: 100, default: "PersistentVolume",                       null: false
    t.string   "accessmode",          limit: 50
    t.string   "storage",             limit: 10,                                                     null: false
    t.string   "phase",               limit: 10
    t.string   "apiversion",          limit: 20,                                                     null: false
    t.string   "pvreclaimpolicy",     limit: 20,  default: "Recycle",                                null: false
    t.string   "pvphase",             limit: 20,                                                     null: false
    t.string   "volumeprovider",      limit: 10,  default: "nfs",                                    null: false
    t.string   "serveraddress",       limit: 20,                                                     null: false
    t.string   "volumename",          limit: 100, default: "replicated-volume",                      null: false
    t.integer  "pvsequencenumber",                default: -> { "nextval('pvsequence'::regclass)" }
    t.uuid     "pvuid"
    t.index ["pvcuid"], name: "pvcuid_provision_constraint", unique: true, using: :btree
  end

end
