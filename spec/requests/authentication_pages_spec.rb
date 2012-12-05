require 'spec_helper'

describe "AuthenticationPages" do
	
	subject { page }
	let (:submit) { "Sign in" }


	describe "sign in page" do
		before { visit signin_path }

		it { should have_correct_h1_content("Sign in") }
		it { should have_selector('title', text: "Sign in") }
	
		describe "with invalid information" do
			before { click_button :submit }

			it { should have_error_message("Invalid") }

			describe "after visiting another page" do
  				before { click_link "Home" }
  				
  				it { should_not have_error_message }
			end
		end

		describe "with valid information" do
		let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

			it { should have_selector('title', text: user.name) }
			it { should have_link('Users', href: users_path) }
			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Settings', href: edit_user_path(user)) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_content('Sign in') }

			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link("Sign in") }
			end
		end

		describe "before signed in" do
		let(:user) { FactoryGirl.create(:user) }

			describe "visit unauthorized user page" do
				before { visit edit_user_path(user) }
				it { should have_correct_h1_content("Sign in") }
			end

			describe "visit users index" do
				before { visit users_path }
				it { should have_correct_h1_content("Sign in") }
			end

			describe "redirect to sign in page" do
				before { put user_path(user) }
				specify { response.should redirect_to(signin_path) }
			end

			describe "create micropost" do
				before { post microposts_path }
				specify { response.should redirect_to(signin_path) }
			end

			describe "delete micropost" do
				before { delete micropost_path(FactoryGirl.create(:micropost)) }
				specify { response.should redirect_to(signin_path) }
			end
		end

		describe "as wrong user" do
		let(:user) { FactoryGirl.create(:user) }
		let(:wronguser) { FactoryGirl.create(:user, email: "wrongemail@example.com") }
		before { sign_in user }

			describe "visiting other users edit page" do
				before { visit edit_user_path(wronguser) }
				it { should_not have_correct_h1_content("Edit profile") }
			end

			describe "visiting other users edit page in the browser" do
				before { put user_path(wronguser) }
				specify { response.should redirect_to(root_path) }
			end
		end
	end

	describe "access edit user page as unauthenticated user" do
	let(:user) { FactoryGirl.create(:user) }
		before do 
			visit edit_user_path(user)
			fill_in "Email", 	with: user.email
			fill_in "Password",	with: user.password
			click_button :submit
		end

		describe "should have friendly forwarding after sign in" do
			it { should have_correct_h1_content("Update") }
		end

		describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the default (profile) page" do
              page.should have_selector('title', text: user.name) 
            end
        end
	end

	describe "for non-signed in users" do
		let(:user) { FactoryGirl.create(:user) }

		describe "in users controller" do

			describe "visiting the following page" do
          		before { visit following_user_path(user) }
          		it { should have_selector('title', text: 'Sign in') }
        	end

        	describe "visiting the followers page" do
          		before { visit followers_user_path(user) }
         		it { should have_selector('title', text: 'Sign in') }
       		end
       	end
    end


	describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
   	  end
   	end   

   	describe "user links should not display when not logged in" do
	   	it { should_not have_link('Profile') }
   		it { should_not have_link('Settings') }
   	end
end

