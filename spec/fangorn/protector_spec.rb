require 'spec_helper'

describe Fangorn::Protection do

  before(:all) do
    self.class.fixtures :departments, :employees, :documents
  end

  before(:each) do
    ## departments
    @marketing   = departments(:marketing)
    @sales       = departments(:sales)
    @west_region = departments(:west_region)
    @finance     = departments(:finance)
    @accounting  = departments(:accounting)
    @receivable  = departments(:receivable)

    ## employees
    @cmo              = employees(:cmo)
    @sales_dir        = employees(:sales_dir)
    @west_region_mgr  = employees(:west_region_mgr)
    @cfo              = employees(:cfo)
    @accounting_mgr   = employees(:accounting_mgr)
    @receivable_supv  = employees(:receivable_supv)

    ## documents
    @marketing_document    = documents(:marketing_document)
    @sales_document        = documents(:sales_document)
    @west_region_document  = documents(:west_region_document)
    @financial_document    = documents(:financial_document)
    @accounting_document   = documents(:accounting_document)
    @receivable_document   = documents(:receivable_document)
  end

  describe '.accessible' do

    context 'when target is the hierarchical security structure class' do

      context 'when the observer is a root node of the hierarchical security structure' do

        it 'should include instances protected by the root node' do
          Department.accessible(@marketing).should include(@marketing)
        end

        it 'should include instances protected by a child node' do
          Department.accessible(@marketing).should include(@sales)
        end

        it 'should include instances protected by a grandchild node' do
          Department.accessible(@marketing).should include(@west_region)
        end

        it 'should not include instances protected by other root node' do
          Department.accessible(@marketing).should_not include(@finance)
        end

        it 'should not include instances protected by other child node' do
          Department.accessible(@marketing).should_not include(@accounting)
        end

        it 'should not include instances protected by other grandchild node' do
          Department.accessible(@marketing).should_not include(@receivable)
        end

      end

      context 'when the observer is a inner node of the hierarchical security structure' do

        it 'should not include instances protected by the parent node' do
          Department.accessible(@sales).should_not include(@marketing)
        end

        it 'should include instances protected the inner node itself' do
          Department.accessible(@sales).should include(@sales)
        end

        it 'should include instances protected by the child node' do
          Department.accessible(@sales).should include(@west_region)
        end

        it 'should not include instances protected by not related root node' do
          Department.accessible(@sales).should_not include(@finance)
        end

        it 'should not include instances protected by not related inner node' do
          Department.accessible(@sales).should_not include(@accounting)
        end

        it 'should not include instances protected by not related left node' do
          Department.accessible(@sales).should_not include(@receivable)
        end

      end

      context 'when the observer is a leaf node of the hierarchical security structure' do

        it 'should not include instances protected by the root node' do
          Department.accessible(@west_region).should_not include(@marketing)
        end

        it 'should not include instances protected the parent node' do
          Department.accessible(@west_region).should_not include(@sales)
        end

        it 'should include instances protected by the leaf node itself' do
          Department.accessible(@west_region).should include(@west_region)
        end

        it 'should not include instances protected by not related root node' do
          Department.accessible(@west_region).should_not include(@finance)
        end

        it 'should not include instances protected by not related inner node' do
          Department.accessible(@west_region).should_not include(@accounting)
        end

        it 'should not include instances protected by not related left node' do
          Department.accessible(@west_region).should_not include(@receivable)
        end

      end

      context "when the observer's access level is granted by a root node of the hierarchical security structure" do

        it 'should include instances protected by the root node' do
          Department.accessible(@cmo).should include(@marketing)
        end

        it 'should include instances protected by a child node' do
          Department.accessible(@cmo).should include(@sales)
        end

        it 'should include instances protected by a grandchild node' do
          Department.accessible(@cmo).should include(@west_region)
        end

        it 'should not include instances protected by other root node' do
          Department.accessible(@cmo).should_not include(@finance)
        end

        it 'should not include instances protected by other child node' do
          Department.accessible(@cmo).should_not include(@accounting)
        end

        it 'should not include instances protected by other grandchild node' do
          Department.accessible(@cmo).should_not include(@receivable)
        end

      end

      context "when the observer's access level is granted by a inner node of the hierarchical security structure" do

        it 'should not include instances protected by the parent node' do
          Department.accessible(@sales_dir).should_not include(@marketing)
        end

        it 'should include instances protected the inner node itself' do
          Department.accessible(@sales_dir).should include(@sales)
        end

        it 'should include instances protected by the child node' do
          Department.accessible(@sales_dir).should include(@west_region)
        end

        it 'should not include instances protected by not related root node' do
          Department.accessible(@sales_dir).should_not include(@finance)
        end

        it 'should not include instances protected by not related inner node' do
          Department.accessible(@sales_dir).should_not include(@accounting)
        end

        it 'should not include instances protected by not related left node' do
          Department.accessible(@sales_dir).should_not include(@receivable)
        end

      end

      context "when the observer's access level is granted by a leaf node of the hierarchical security structure" do

        it 'should not include instances protected by the root node' do
          Department.accessible(@west_region_mgr).should_not include(@marketing)
        end

        it 'should not include instances protected the parent node' do
          Department.accessible(@west_region_mgr).should_not include(@sales)
        end

        it 'should include instances protected by the leaf node itself' do
          Department.accessible(@west_region_mgr).should include(@west_region)
        end

        it 'should not include instances protected by not related root node' do
          Department.accessible(@west_region_mgr).should_not include(@finance)
        end

        it 'should not include instances protected by not related inner node' do
          Department.accessible(@west_region_mgr).should_not include(@accounting)
        end

        it 'should not include instances protected by not related left node' do
          Department.accessible(@west_region_mgr).should_not include(@receivable)
        end

      end

    end

    context 'when target is protected by an instance of the hierarchical security structure class' do

      context 'when the observer is a root node of the hierarchical security structure' do

        it 'should include instances protected by the root node' do
          Employee.accessible(@marketing).should include(@marketing_document)
        end

        it 'should include instances protected by a child node' do
          Employee.accessible(@marketing).should include(@sales_document)
        end

        it 'should include instances protected by a grandchild node' do
          Employee.accessible(@marketing).should include(@west_region_document)
        end

        it 'should not include instances protected by other root node' do
          Employee.accessible(@marketing).should_not include(@financial_document)
        end

        it 'should not include instances protected by other child node' do
          Employee.accessible(@marketing).should_not include(@accounting_document)
        end

        it 'should not include instances protected by other grandchild node' do
          Employee.accessible(@marketing).should_not include(@receivable_document)
        end

      end

      context 'when the observer is a inner node of the hierarchical security structure' do

        it 'should not include instances protected by the parent node' do
          Employee.accessible(@sales).should_not include(@marketing_document)
        end

        it 'should include instances protected the inner node itself' do
          Employee.accessible(@sales).should include(@sales_document)
        end

        it 'should include instances protected by the child node' do
          Employee.accessible(@sales).should include(@west_region_document)
        end

        it 'should not include instances protected by not related root node' do
          Employee.accessible(@sales).should_not include(@financial_document)
        end

        it 'should not include instances protected by not related inner node' do
          Employee.accessible(@sales).should_not include(@accounting_document)
        end

        it 'should not include instances protected by not related left node' do
          Employee.accessible(@sales).should_not include(@receivable_document)
        end

      end

      context 'when the observer is a leaf node of the hierarchical security structure' do

        it 'should not include instances protected by the root node' do
          Employee.accessible(@west_region).should_not include(@marketing_document)
        end

        it 'should not include instances protected the parent node' do
          Employee.accessible(@west_region).should_not include(@sales_document)
        end

        it 'should include instances protected by the leaf node itself' do
          Employee.accessible(@west_region).should include(@west_region_document)
        end

        it 'should not include instances protected by not related root node' do
          Employee.accessible(@west_region).should_not include(@financial_document)
        end

        it 'should not include instances protected by not related inner node' do
          Employee.accessible(@west_region).should_not include(@accounting_document)
        end

        it 'should not include instances protected by not related left node' do
          Employee.accessible(@west_region).should_not include(@receivable_document)
        end

      end

      context "when the observer's access level is granted by a root node of the hierarchical security structure" do

        it 'should include instances protected by the root node' do
          Employee.accessible(@cmo).should include(@marketing_document)
        end

        it 'should include instances protected by a child node' do
          Employee.accessible(@cmo).should include(@sales_document)
        end

        it 'should include instances protected by a grandchild node' do
          Employee.accessible(@cmo).should include(@west_region_document)
        end

        it 'should not include instances protected by other root node' do
          Employee.accessible(@cmo).should_not include(@financial_document)
        end

        it 'should not include instances protected by other child node' do
          Employee.accessible(@cmo).should_not include(@accounting_document)
        end

        it 'should not include instances protected by other grandchild node' do
          Employee.accessible(@cmo).should_not include(@receivable_document)
        end

      end

      context "when the observer's access level is granted by a inner node of the hierarchical security structure" do

        it 'should not include instances protected by the parent node' do
          Employee.accessible(@sales_dir).should_not include(@marketing_document)
        end

        it 'should include instances protected the inner node itself' do
          Employee.accessible(@sales_dir).should include(@sales_document)
        end

        it 'should include instances protected by the child node' do
          Employee.accessible(@sales_dir).should include(@west_region_document)
        end

        it 'should not include instances protected by not related root node' do
          Employee.accessible(@sales_dir).should_not include(@financial_document)
        end

        it 'should not include instances protected by not related inner node' do
          Employee.accessible(@sales_dir).should_not include(@accounting_document)
        end

        it 'should not include instances protected by not related left node' do
          Employee.accessible(@sales_dir).should_not include(@receivable_document)
        end

      end

      context "when the observer's access level is granted by a leaf node of the hierarchical security structure" do

        it 'should not include instances protected by the root node' do
          Employee.accessible(@west_region_mgr).should_not include(@marketing_document)
        end

        it 'should not include instances protected the parent node' do
          Employee.accessible(@west_region_mgr).should_not include(@sales_document)
        end

        it 'should include instances protected by the leaf node itself' do
          Employee.accessible(@west_region_mgr).should include(@west_region_document)
        end

        it 'should not include instances protected by not related root node' do
          Employee.accessible(@west_region_mgr).should_not include(@financial_document)
        end

        it 'should not include instances protected by not related inner node' do
          Employee.accessible(@west_region_mgr).should_not include(@accounting_document)
        end

        it 'should not include instances protected by not related left node' do
          Employee.accessible(@west_region_mgr).should_not include(@receivable_document)
        end

      end

    end

  end

  describe '#accesible?' do

    context 'when target is a root node of the hierarchical security structure' do

      it 'can be accessed by itself' do
        @marketing.accessible?(@marketing).should be_true
      end

      it "can't be accessed by a child node" do
        @marketing.accessible?(@sales).should be_false
      end

      it "can't be accessed by a grandchild node" do
        @marketing.accessible?(@west_region).should be_false
      end

      it "can't be accessed by an other root node" do
        @marketing.accessible?(@finance).should be_false
      end

      it "can't be accessed by an other root's child node" do
        @marketing.accessible?(@accounting).should be_false
      end

      it "can't be accessed by an other root's grandchild node" do
        @marketing.accessible?(@receivable).should be_false
      end

      it 'can be accessed by an observer when the root node grant the access level' do
        @marketing.accessible?(@cmo).should be_true
      end

      it "can't be accessed by an observer when a child node grant the access level" do
        @marketing.accessible?(@sales_dir).should be_false
      end

      it "can't be accessed by an observer when a grandchild node grant the access level" do
        @marketing.accessible?(@west_region_mgr).should be_false
      end

      it "can't be accessed by an observer when an other root node grant the access level" do
        @marketing.accessible?(@cfo).should be_false
      end

      it "can't be accessed by an observer when an other root's child node grant the access level" do
        @marketing.accessible?(@accounting_mgr).should be_false
      end

      it "can't be accessed by an observer when an other root's child node grant the access level" do
        @marketing.accessible?(@receivable_supv).should be_false
      end

    end

    context "when target is an inner node of the hierarchical security structure" do

      it "can be accessed by its parent node" do
        @sales.accessible?(@marketing).should be_true
      end

      it 'can be accessed by itself' do
        @sales.accessible?(@sales).should be_true
      end

      it "can't be accessed by its child node" do
        @sales.accessible?(@west_region).should be_false
      end

      it "can't be accessed by a not related root node" do
        @sales.accessible?(@finance).should be_false
      end

      it "can't be accessed by a not related inner node" do
        @sales.accessible?(@accounting).should be_false
      end

      it "can't be accessed by a not related leaf node" do
        @sales.accessible?(@receivable).should be_false
      end

      it "can be accessed by an observer when the node's parent grant the access level" do
        @sales.accessible?(@cmo).should be_true
      end

      it "can be accessed by an observer when the node itself grant the access level" do
        @sales.accessible?(@sales_dir).should be_true
      end

      it "can't be accessed by an observer when the node's child grant the access level" do
        @sales.accessible?(@west_region_mgr).should be_false
      end

      it "can't be accessed by an observer when a not related root node grant the access level" do
        @sales.accessible?(@cfo).should be_false
      end

      it "can't be accessed by an observer when a not related inner node grant the access level" do
        @sales.accessible?(@accounting_mgr).should be_false
      end

      it "can't be accessed by an observer when a not related leaf node grant the access level" do
        @sales.accessible?(@receivable_supv).should be_false
      end

    end

    context "when target is a leaf node of the hierarchical security structure" do

      it "can be accessed by its root node" do
        @west_region.accessible?(@marketing).should be_true
      end

      it "can be accessed by its parent node" do
        @west_region.accessible?(@sales).should be_true
      end

      it 'can be accessed by itself' do
        @west_region.accessible?(@west_region).should be_true
      end

      it "can't be accessed by a not related root node" do
        @west_region.accessible?(@finance).should be_false
      end

      it "can't be accessed by a not related inner node" do
        @west_region.accessible?(@accounting).should be_false
      end

      it "can't be accessed by a not related leaf node" do
        @west_region.accessible?(@receivable).should be_false
      end

      it "can be accessed by an observer when the root node grant the access level" do
        @west_region.accessible?(@cmo).should be_true
      end

      it "can be accessed by an observer when the parent node grant the access level" do
        @west_region.accessible?(@sales_dir).should be_true
      end

      it "can be accessed by an observer when the leaf node itself grant the access level" do
        @west_region.accessible?(@west_region_mgr).should be_true
      end

      it "can't be accessed by an observer when a not related root node grant the access level" do
        @west_region.accessible?(@cfo).should be_false
      end

      it "can't be accessed by an observer when a not related inner node grant the access level" do
        @west_region.accessible?(@accounting_mgr).should be_false
      end

      it "can't be accessed by an observer when a not related leaf node grant the access level" do
        @west_region.accessible?(@receivable_supv).should be_false
      end

    end

    context 'when target is an object protected by a root node of the hierachical security structure' do

      it 'can be accessed by the root node' do
        @marketing_document.accessible?(@marketing).should be_true
      end

      it "can't be accessed by a child node" do
        @marketing_document.accessible?(@sales).should be_false
      end

      it "can't be accessed by a grandchild node" do
        @marketing_document.accessible?(@west_region).should be_false
      end

      it "can't be accessed by an other root node" do
        @marketing_document.accessible?(@finance).should be_false
      end

      it "can't be accessed by an other root's child node" do
        @marketing_document.accessible?(@accounting).should be_false
      end

      it "can't be accessed by an other root's grandchild node" do
        @marketing_document.accessible?(@receivable).should be_false
      end

      it 'can be accessed by an observer when the root node grant the access level' do
        @marketing_document.accessible?(@cmo).should be_true
      end

      it "can't be accessed by an observer when a child node grant the access level" do
        @marketing_document.accessible?(@sales_dir).should be_false
      end

      it "can't be accessed by an observer when a grandchild node grant the access level" do
        @marketing_document.accessible?(@west_region_mgr).should be_false
      end

      it "can't be accessed by an observer when an other root node grant the access level" do
        @marketing_document.accessible?(@cfo).should be_false
      end

      it "can't be accessed by an observer when an other root's child node grant the access level" do
        @marketing_document.accessible?(@accounting_mgr).should be_false
      end

      it "can't be accessed by an observer when an other root's child node grant the access level" do
        @marketing_document.accessible?(@receivable_supv).should be_false
      end

    end

    context "when target is an object protected by an inner node of the hierarchical security structure" do

      it "can be accessed by the protector node's parent" do
        @sales_document.accessible?(@marketing).should be_true
      end

      it 'can be accessed by the protector node itself' do
        @sales_document.accessible?(@sales).should be_true
      end

      it "can't be accessed by a protector's child node" do
        @sales_document.accessible?(@west_region).should be_false
      end

      it "can't be accessed by a not related root node" do
        @sales_document.accessible?(@finance).should be_false
      end

      it "can't be accessed by a not related inner node" do
        @sales_document.accessible?(@accounting).should be_false
      end

      it "can't be accessed by a not related leaf node" do
        @sales_document.accessible?(@receivable).should be_false
      end

      it "can be accessed by an observer when the protector's parent node grant the access level" do
        @sales_document.accessible?(@cmo).should be_true
      end

      it "can be accessed by an observer when the protector node itself grant the access level" do
        @sales_document.accessible?(@sales_dir).should be_true
      end

      it "can't be accessed by an observer when the protector's child node grant the access level" do
        @sales_document.accessible?(@west_region_mgr).should be_false
      end

      it "can't be accessed by an observer when a not related root node grant the access level" do
        @sales_document.accessible?(@cfo).should be_false
      end

      it "can't be accessed by an observer when a not related inner node grant the access level" do
        @sales_document.accessible?(@accounting_mgr).should be_false
      end

      it "can't be accessed by an observer when a not related leaf node grant the access level" do
        @sales_document.accessible?(@receivable_supv).should be_false
      end

    end

    context "when target is protected by a leaf node of the hierarchical security structure" do

      it "can be accessed by the protector's root node" do
        @west_region_document.accessible?(@marketing).should be_true
      end

      it "can be accessed by the protector's parent node" do
        @west_region_document.accessible?(@sales).should be_true
      end

      it 'can be accessed by the leaf node itself' do
        @west_region_document.accessible?(@west_region).should be_true
      end

      it "can't be accessed by a not related root node" do
        @west_region_document.accessible?(@finance).should be_false
      end

      it "can't be accessed by a not related inner node" do
        @west_region_document.accessible?(@accounting).should be_false
      end

      it "can't be accessed by a not related leaf node" do
        @west_region_document.accessible?(@receivable).should be_false
      end

      it "can be accessed by an observer when the protector's root node grant the access level" do
        @west_region_document.accessible?(@cmo).should be_true
      end

      it "can be accessed by an observer when the protector's parent node grant the access level" do
        @west_region_document.accessible?(@sales_dir).should be_true
      end

      it "can be accessed by an observer when the protector node itself grant the access level" do
        @west_region_document.accessible?(@west_region_mgr).should be_true
      end

      it "can't be accessed by an observer when a not related root node grant the access level" do
        @west_region_document.accessible?(@cfo).should be_false
      end

      it "can't be accessed by an observer when a not related inner node grant the access level" do
        @west_region_document.accessible?(@accounting_mgr).should be_false
      end

      it "can't be accessed by an observer when a not related leaf node grant the access level" do
        @west_region_document.accessible?(@receivable_supv).should be_false
      end

    end

  end

  describe '#accesible!' do
    pending 'Specs similares a accesible? pero lanzando excepciones.'
  end

end

